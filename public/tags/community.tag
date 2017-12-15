<community>

  <p>Filter by: <select>
    <option>1</option>
    <option>2</option>
    <option>3</option>
    </select>
  </p>
  <ul>
    <comm-prev each={allrecipes}></comm-prev>
  </ul>

</div>

<script>
  var that = this;
  that.user = firebase.auth().currentUser;
  that.allrecipes = [];
  console.log("community loaded");

  var allRecipesRef = firebase.database().ref("recipes");
  allRecipesRef.on('value', function(snapshot){
    var data = snapshot.val()
    for (var i in data) {
      that.allrecipes.push(data[i]);
    }
  })

</script>

<style>

</style>

</community>
