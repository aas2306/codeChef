<home>
  <div class="row title">
    <h1>codeChef</h1>
  </div>

  <div if={showwelcome} id="welcomePage">
    <h1 id="welcomeBanner">Welcome to codeChef</h1>
    <p class="introText">Learn coding syntax while creating and sharing recipes!</p>
  </div>

  <my-pantry if={showpantry}></my-pantry>

  <div class="community" if={showcomm}>
    <community></community>
  </div>


  <script>
    var that = this;
    that.user = firebase.auth().currentUser;
    that.showwelcome = true;
    that.showpantry = false;
    that.showcomm = false;

    that.goToPantry = function() {
        that.showwelcome = false;
        that.showpantry = true;
        that.showcomm = false;
        that.update();
    }
    that.goToComm = function() {
        that.showwelcome = false;
        that.showpantry = false;
        that.showcomm = true;
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

  </style>
</home>
