<new-recipe>

  <div>
  <!-- TITLE -->
    <h4><strong>{recipeTitle}()</strong></h4>
  <!-- EDIT TITLE AND NUMBER OF SERVINGS -->
    <div if={titleAndServ}  onkeypress={onEnterKey}>
      <div class="form-group">
        <label>Recipe Title:</label>
        <input class="form-control" type="text" ref="recipeTitle">
        <em style="color:slategrey">Title cannot include spaces. Try to use camelCaseFormat.</em>
      </div>
      <div class="form-group">
        <label for="">Number of servings yielded:</label><input class="form-control" type="number" ref="numServ">
      </div>
      <button type="button" class="nextBtn" onclick={saveTitleAndServ}>Next <span> <i class="fa fa-arrow-right" aria-hidden="true"></i></span> </button>
    </div>
<!-- NUMBER OF SERVINGS -->
    <div if={!titleAndServ}>
      <p><strong>numServ</strong> = {numServ}</p>
    </div>

<!-- INGREDIENTS -->
    <div if={ingredientsDiv}>
      <h4>This is the ingredients div.</h4>
    </div>

    <!-- <div class="titleandServ">
      <div class="recipetitle">
        <h4 if={!editmode} onclick={editTitle}>{title}()</h4>
        <input ref="newTitle" type="text" if={editmode} onmouseout={updateTitle}>
      </div>
    </div> -->

  </div>



<script>
  var that = this;
  that.titleAndServ = true;
  that.ingredientsDiv = false;
  that.recipeTitle = "newRecipe";
  that.numServ;
  that.newRecipe = {};

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
    console.log(that.newRecipe);
// this line will be changed to happen when have the whole recipe?
    that.sendToFirebase();
    that.ingredientsDiv = true;
  }

  that.sendToFirebase = function() {
    var database = firebase.database();
    var newRecipesRef = database.ref('recipes');
    var newKey = newRecipesRef.push().key;
    that.newRecipe.id = newKey;
    newRecipesRef.child(newKey).set(that.newRecipe);
  }
  // var database = firebase.database();
  //   var privateListRef = database.ref('privateList/' + this.user.uid);
  //   var newKey = privateListRef.push().key;
  //   newPrivatePost.postID = newKey;
  //   privateListRef.child(newKey).set(newPrivatePost);

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

  // <!-- that.editmode = false;
  // that.title = "newRecipe";
  //
  // that.editTitle = function() {
  //   that.editmode = true;
  // }
  // that.updateTitle = function() {
  //   that.editMode = false;
  //   that.title = that.refs.newTitle.value;
  // } -->



</script>


<style>
  .recipeTitle {
    cursor: text;
  }
  .nextBtn {
     color: white;
     background-color: teal;
     font-size: 18px;
     padding: 5px;
  }

</style>

</new-recipe>
