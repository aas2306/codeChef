<preview>
  <li onclick={loadFullRecipe}>
    {thisRecipe.recipeTitle} ()
  </li>

<script>
  var that = this;
  that.user = firebase.auth().currentUser;
  // console.log("that", that);
  that.thisRecipe;

  var thisRecipeRef = firebase.database().ref(`private/${that.user.uid}/myrecipes/${this.id}`);

  thisRecipeRef.on('value', function(snapshot) {
    that.thisRecipe = snapshot.val();
    console.log("this recipe",that.thisRecipe);
  })

</script>

<style>

</style>

</preview>
