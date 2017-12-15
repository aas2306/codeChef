<preview>
  <li onclick={parent.parent.goToView}>
    {thisRecipe.recipeTitle} ()
  </li>

<script>
  var that = this;
  that.user = firebase.auth().currentUser;
  that.thisRecipe;

  var thisRecipeRef = firebase.database().ref(`private/${that.user.uid}/myrecipes/${this.id}`);

  thisRecipeRef.on('value', function(snapshot) {
    that.thisRecipe = snapshot.val();
    // console.log("this recipe",that.thisRecipe);
  })

  // that.loadFullRecipe = function() {
  //   console.log("hey");
  //   console.log(that.parent.parent);
  //   that.parent.parent.goToView(that.thisRecipe);
  // }

</script>

<style>
  li {
    text-decoration: underline;
    cursor: pointer;
  }

</style>

</preview>
