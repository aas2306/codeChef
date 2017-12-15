<my-pantry>


<div class="row" style="margin: 0px 0px 0px 10px;" if={!newrecipe}>
  <!-- <div  > -->
    <div class="col-4 pantry">
      <h5>My Pantry</h5>
      <button type="button" class="btn" onclick={ newRec }>newRecipe()</button>
      <ul>
        <preview each={previews}></preview>
      </ul>
  </div>
  <div class="col-8 viewrec">
    <view-recipe if={viewrecipe}></view-recipe>
  </div>
</div>

<div class="row">
  <div class="col" if={ newrecipe }>
    <new-recipe></new-recipe>
  </div>
</div>



<script>
  var that = this;
  that.newrecipe = false;
  that.viewrecipe = false;
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
