<my-pantry>

<div>
  <h5>My Pantry</h5>
  <button type="button" style="background-color: palegoldenrod;" onclick={ newRecipe }>newRecipe()</button>
</div>

<script>
  var that = this;

  that.newRecipe = function() {
    that.parent.newRecipePane = true;
    that.parent.update();
  }

</script>


<style>

</style>

</my-pantry>
