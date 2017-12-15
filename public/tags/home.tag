<home>
  <div class="row title">
    <h1>codeChef(<span> <i class="fa fa-cutlery"></i> </span>)</h1>
  </div>

  <div if={showwelcome} id="welcomePage">
    <h1 id="welcomeBanner">Welcome to codeChef</h1>
    <p class="introText">Learn coding syntax while creating and sharing recipes!</p>
  </div>

<!-- my pantry  / community, and view recipe -->
  <div if={maincontent}>
    <div class="row changingHeader">
      <div if={showpantry}>
        <h2>My Pantry</h2>
        <h5>View and edit your own recipes</h5>
      </div>
      <div if={showcomm}>
        <h2>codeChef Community</h2>
        <h5>View and remix other recipes</h5>
      </div>
    </div>
    <div class="row" style="margin: 0px 10px 0px 10px;">
      <div class="col-3 sideColumn">
        <my-pantry if={showpantry}></my-pantry>
        <community if={showcomm}></community>
      </div>
      <div class="col-9 viewrec">
        <show-recipe if={showfullrec} recipe={recToShow}></show-recipe>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col" if={ shownew }>
      <new-recipe></new-recipe>
    </div>
  </div>


  <script>
    var that = this;
    that.user = firebase.auth().currentUser;
    that.showwelcome = true;
    that.showpantry = false;
    that.shownew = false;
    that.showcomm = false;
    that.showfullrec = false;
    that.maincontent = false;

    that.goToPantry = function() {
        that.showwelcome = false;
        that.maincontent = true;
        that.showpantry = true;
        that.shownew = false;
        that.showcomm = false;
        that.showfullrec = false;
        that.update();
    }
    that.goToComm = function() {
        that.showwelcome = false;
        that.maincontent = true;
        that.showpantry = false;
        that.shownew = false;
        that.showcomm = true;
        that.showfullrec = false;
        that.update();
    }
    that.goToNew = function() {
      that.showwelcome = false;
      that.maincontent = false;
      that.showpantry = false;
      that.showcomm = false;
      that.shownew = true;
      that.showfullrec = false;
      that.update();
    }
    that.recToShow;
    that.goToView = function(e) {
      that.showfullrec = false;
      that.update();
      that.recToShow = e.item;
      that.showfullrec = true;
      that.update();
    }

  </script>

  <style>
    .title {
      margin: 10px;
      padding: 20px;
      background-color: tomato;
      color: white;
    }
    #welcomePage {
      background-color: palegoldenrod;
      margin: 10px;
      height: 400px;
    }
    #welcomeBanner {
      text-align: center;
      color: teal;
      font-weight: bold;
      font-size: 3em;
      padding-top: 30px;
      letter-spacing: 2px;
    }
    .introText {
      color: tomato;
      text-align: center;
      font-size: 1.5em;
    }
    .btn {
       color: white;
       background-color: teal;
       font-size: 18px;
       padding: 5px;
       margin: 2px;
       max-height: 50px;
    }
    .community {
      background-color: palegoldenrod;
      min-height: 400px;
      margin: 5px;
      padding: 20px;
    }
    .changingHeader {
      background-color: palegoldenrod;
      margin: 5px 10px 5px 10px;
      padding: 20px;
    }
    .changingHeader h2 {
      color: teal;
      font-weight: bold;
    }
    .changingHeader h5 {
      color: tomato;
    }
    .sideColumn {
      background-color: teal;
      color: white;
      padding: 15px;
    }
    .viewrec {
      background-color: palegoldenrod;
      padding: 20px;
    }

  </style>
</home>
