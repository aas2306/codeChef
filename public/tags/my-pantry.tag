<my-pantry>

  <p>Sort by:
    <select>
      <option>1</option>
      <option>2</option>
      <option>3</option>
    </select>
  </p>
  <ul>
    <preview each={previews}></preview>
  </ul>

<script>
  var that = this;
  that.newrecipe = false;
  // that.viewrecipe = false;
  that.previews = [];
  that.user = firebase.auth().currentUser;

  that.newRec = function() {
    that.newrecipe = true;
    that.update();
  }

  that.on('mount', function(){
    var myrecipesref = firebase.database().ref(`private/${that.user.uid}/myrecipes`);
    myrecipesref.on('value', function(snapshot) {
      var data = snapshot.val();
      for (var i in data) {
        that.previews.push(data[i]);
        that.update();
      }
    })
  })

</script>

<style>
.pantry {
  padding: 10px;
  background-color: teal;
  color: white;
}
.pantry button {
  background-color: palegoldenrod;
  color: black;
}
.viewrec {
  background-color: palegoldenrod;
}

</style>

</my-pantry>
