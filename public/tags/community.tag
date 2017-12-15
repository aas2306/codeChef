<community>

  <h2>codeChef Community</h2>
  <h5>View and remix other recipes</h5>

<div class="row">
    <div class="col-4">
      <ul>
        <comm-prev each={allrecipes}></comm-prev>
      </ul>
    </div>

    <div class="col-8">
      <view-recipe></view-recipe>
    </div>

</div>

<script>
  var that = this;
  that.user = firebase.auth().currentUser;
  that.allrecipes = [];

  var allRecipesRef = firebase.database().ref("recipes");
  allRecipesRef.on('value', function(snapshot){
    var data = snapshot.val()
    for (var i in data) {
      that.allrecipes.push(data[i]);
    }
  })

</script>

<style>
  h2 {
    color: teal;
    font-weight: bold;
  }
  h5 {
    color: tomato;
  }

</style>

</community>
