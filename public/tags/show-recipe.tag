<show-recipe>
  <h4>{recipe.recipeTitle}()</h4>
  <p>Recipe by {recipe.author}</p>

  <div class="row">
    <div class="col">
      <h6>Your Code</h6>
      <div ref="code" class="box">

      </div>
    </div>
    <div class="col">
      <h6>Printed Recipe</h6>
      <div ref="printed" class="box">

      </div>
    </div>
  </div>

  <button class="btn showrecbtn" type="button" if={myrecipe}>Edit</button>
  <button class="btn showrecbtn" type="button" if={!myrecipe}>Add to Pantry</button>

<script>
  var that = this;
  that.recipe = that.opts.recipe;
  console.log("recipe", that.recipe);
  that.user = firebase.auth().currentUser;

  // sets printed text
  that.on('mount', function(){
    console.log(that.recipe.codetext);
    that.refs.printed.innerHTML = that.recipe.printtext;
    that.update();
  })

  // changes \n to enter
  that.on('mount', function() {
    var string = that.recipe.codetext;
    if (string.includes('\n')) {
      string = string.split('\n').join('<br>');
      that.refs.code.innerHTML = string;
    } else {
      that.refs.code.innerHTML = string;
    }
    that.update();
  })

  var recipeRef = firebase.database().ref(`recipes/${that.recipe.id}/userid`);
  recipeRef.once('value', function(snapshot){
    that.userid = snapshot.val();
  })
  if (that.user.uid === that.userid) {
    that.myrecipe = true;
  } else {
    that.myrecipe = false;
  }

</script>

<style>
  h4 {
    color: tomato;
    font-weight: bold;
  }
  h6 {
    color: teal;
  }
  .box {
    padding-left: 40px;
    background-color: rgba(255, 255, 255, 0.5);
  }
  .box ol {
    padding: 0px;
  }
  .showrecbtn {
    font-size: 14px;
    position: absolute;
    right: 10%;
    margin: 10px;
  }

</style>

</show-recipe>
