<home>
  <div class="row title">
    <h1>codeChef</h1>
  </div>

  <div class="row" style="margin: 0px 0px 0px 10px;">
    <div class="col-4 pantry">
      <my-pantry></my-pantry>
      <!-- each= in my pantry will be a recipe -->
    </div>
    <div class="col-8">
      <!-- what stuff here? -->
      <div class="newrecipe">
        <new-recipe if={ newRecipePane }></new-recipe>
      </div>
    </div>

  </div>

  <script>
    var that = this;
    that.newRecipePane = false;

  </script>

  <style>
    .title {
      margin: 10px;
      padding: 20px;
      background-color: tomato;
      color: white;
    }
    .pantry {
      padding: 10px;
      background-color: teal;
      color: white;
    }
    .newrecipe {
      background-color: palegoldenrod;
      padding: 10px;
    }

  </style>
</home>
