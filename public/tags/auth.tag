<auth>

  <div class="navBtns">
    <button if={user} onclick={goToComm} type="button" class="btn" id="communityBtn">Community</button>
    <button if={user} onclick={goToPantry} type="button" class="btn">My Pantry</button>
    <button if={!user} onclick={logIn} type="button" class="btn" id="">Log In</button>
    <button if={user} onclick={logOut} type="button" class="btn" id="">Log Out</button>
  </div>

    <script>

        var that = this;
        // this.user = firebase.auth().currentUser;
        firebase.auth().onAuthStateChanged(function (userObj) {
            if (userObj) {
                that.user = userObj;
            } else {
                that.user = null;
            }
            // that.user = firebase.auth().currentUser;
            that.update();
        });
        var user,
            name,
            email,
            photoUrl,
            uid;
        if (user != null) {
            name = user.displayName;
            email = user.email;
            photoUrl = user.photoURL;
            uid = user.uid;
        }

        this.logIn = function(event) {
            var provider = new firebase.auth.GoogleAuthProvider();
            firebase.auth().signInWithPopup(provider).then(function (result) {
                user = result.user;
            }).catch(function (error) {
                console.log('Error:', error.code, error.message);
                console.log('Email of account used:', error.email);
                console.log('Credential type used;', error.credential);
            });
        }

        this.logOut = function(event) {
            firebase.auth().signOut();
            that.update;
        }
        that.goToPantry = function() {
          that.root.nextElementSibling._tag.goToPantry();
        }
        that.goToComm = function() {
          that.root.nextElementSibling._tag.goToComm();
        }

    </script>

    <style>
        .btn {
           color: white;
           background-color: teal;
           font-size: 18px;
           padding: 5px;
           margin: 2px;
           max-height: 50px;
        }
        .navBtns {
          position: absolute;
          right: 35px;
          top: 35px;
          z-index: 99%;
        }
        #communityBtn {
          background-color: palegoldenrod;
          color: black;
        }

    </style>
</auth>
