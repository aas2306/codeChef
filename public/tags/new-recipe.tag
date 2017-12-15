<new-recipe>

  <div class="row" style="margin: 0px 10px 0px 10px;">

    <div class="col-3 newrecipe">
      <!-- TITLE -->
        <h4><strong>{recipeTitle}</strong></h4>
      <!-- EDIT TITLE AND NUMBER OF SERVINGS -->
        <div if={titleAndServ}  onkeypress={onEnterKey}>
          <div class="form-group">
            <label>Recipe Title:</label>
            <input class="form-control" type="text" ref="recipeTitle">
            <em style="color:slategrey">Title cannot include spaces. Try to use camelCaseFormat.</em>
          </div>
          <div class="form-group">
            <label>Number of servings yielded:</label><input class="form-control" type="number" ref="numServ">
          </div>
          <button type="button" class="btn" onclick={saveTitleAndServ}>Next <span> <i class="fa fa-arrow-right" aria-hidden="true"></i></span> </button>
        </div>
    <!-- NUMBER OF SERVINGS -->
        <div if={!titleAndServ}>
          <p><strong>numServ</strong> = {numServ}</p>
        </div>

    <!-- INGREDIENTS -->
        <div if={ingredientsDiv}>
          <em style="color:slategrey">Input the ingredients needed for this recipe here.</em>
          <h4>Ingredients: {</h4>
            <ingredient-input each={ingrList}></ingredient-input>
            <button type="button" class="btn" onclick={makeNewIngr}>Add Ingredient<span><i class="fa fa-plus" aria-hidden="true"></i></span></button>

          <h4>}</h4>
          <button type="button" class="btn" onclick={submitIngredients}>Next <span> <i class="fa fa-arrow-right" aria-hidden="true"></i></span></button>
        </div>

        <div if={showIngr}>
          <p style="color:teal;"><strong>Ingredients:  </strong></p>
            <div style="margin-left: 20px;" each={ingredients} ref="ingrToDrag" draggable="true">
              <li><strong style="color: tomato;">{ingrName}</strong><span>: { </span> <span>qty</span>: {qty} {qtyType} <span> } </span></li>
            </div>
          <p style="color:teal;"><strong></strong></p>
        </div>
    </div>

    <div class="col-9 writeRec">
        <write-recipe ref="writeEl" rec={recipe} if={writerecipe}></write-recipe>
    </div>

  </div>


<script>
  var that = this;
  that.database = firebase.database();
  that.titleAndServ = true;
  that.ingredientsDiv = false;
  that.showIngr = false;
  that.writerecipe = false;
  that.recipeTitle = "newRecipe";
  that.numServ;
  that.newRecipe = {};
  that.ingredients = [];
  that.recipe;


  that.saveTitleAndServ = function() {
    that.recipeTitleInput = that.refs.recipeTitle.value;
    that.numServInput = that.refs.numServ.value;
    if (!that.validation(that.numServInput)) {
      return;
    }
    if (!that.validateText(that.recipeTitleInput)) {
      return;
    }
    // this saves locally. CHANGE so that it GETS this data from firebase and puts on HTML
    that.recipeTitle = that.recipeTitleInput;
    that.numServ = that.numServInput;
    // this puts it in an object for firebase
    that.newRecipe.recipeTitle = that.recipeTitleInput;
    that.newRecipe.numServ = that.numServInput;
    that.titleAndServ = false;
    // this line will be changed to happen when have the whole recipe?
    that.sendToFirebase();
    that.ingredientsDiv = true;
  }

  that.sendToFirebase = function() {
    var newRecipesRef = that.database.ref('recipes');
    var newKey = newRecipesRef.push().key;
    that.newRecipe.id = newKey;
    newRecipesRef.child(newKey).set(that.newRecipe);
  }

  that.onEnterKey = function(e) {
  	if (e.code === "Enter") {
  		that.saveTitleAndServ();
  	}
  }

  that.validation = function(x) {
	  if (x !== "") {
		  return true;
	  } else {
      alert("All fields are required.");
		  return false;
	  }
  }

  that.validateText = function(str) {
    if (str == "") {
      alert("All fields are required.");
      return false;
    } else if (str.indexOf(' ') >= 0){
      alert("Recipe title cannot include spaces. Please use camelCaseFormat for multi-worded titles.");
      return false;
    } else {
      return true;
    }
  }

  that.ingrList = [];

  that.makeNewIngr = function() {
    var x = {ingredient: ""};
    that.ingrList.push(x);
  }

// `recipes/${that.newRecipe.id}`
  that.getRecipePartOne = function() {
    var recipeRef = firebase.database().ref("recipes/" + that.newRecipe.id);
    recipeRef.on('value', function(snapshot){
      var data = snapshot.val();
      that.recipe = data;
      that.update();
    })
  }

  that.submitIngredients = function() {
    var array = that.tags["ingredient-input"];
    array.forEach(function(i) {
      var ingredientsRef = that.database.ref(`recipes/${that.newRecipe.id}/inputs/ingredients/${i.refs.ingrName.value}`);

      var ingrObj = {
        ingrName: i.refs.ingrName.value,
        qty: i.refs.qty.value,
        qtyType: i.refs.qtyType.value
      };
      ingredientsRef.set(ingrObj);
    });
    that.ingredientsDiv = false;
    that.getRecipePartOne();
    that.update();
    that.showIngredients();
  }

  that.showIngredients = function() {
    var ingredientsRef = that.database.ref(`recipes/${that.newRecipe.id}/inputs/ingredients`);

    ingredientsRef.once("value").then(function(snapshot){
      var data = snapshot.val();
      var ingrArray = [];
      for (var key in data) {
        ingrArray.push(data[key]);
      }
      that.ingredients = ingrArray;
      that.update();
    })
    that.showIngr = true;
    that.writerecipe = true;
    that.update();
    // that.tags['write-recipe'].runFunc();
  }

</script>


<style>
  .recipeTitle {
    cursor: text;
  }
  .btn {
     color: white;
     background-color: teal;
     font-size: 18px;
     padding: 5px;
  }
  .newrecipe {
    background-color: palegoldenrod;
    padding: 10px;
  }
  .writeRec {
    background-color: tomato;
    padding: 10px;
  }
  [draggable=true]{
    cursor: move;
  }

</style>

</new-recipe>
