<comm-prev>
  <li>
    {thisRecipe.recipeTitle} ()
  </li>

<script>
  var that = this;
  // that.user = firebase.auth().currentUser;
  // console.log("that", that);
  console.log("")
  that.thisRecipe;

  var thisRecipeRef = firebase.database().ref(`recipes/${this.id}`);

  thisRecipeRef.on('value', function(snapshot) {
    that.thisRecipe = snapshot.val();
    console.log("this recipe",that.thisRecipe);
  })

</script>

<style>
  li {
    color: black;
  }

</style>

</comm-prev>
