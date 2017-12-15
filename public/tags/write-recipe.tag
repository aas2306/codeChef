<write-recipe>

  <div class="row">
    <div class="col textCode">
      {console.log('interpolating')}
      <h4>{opts.rec ? opts.rec.recipeTitle : ""}()</h4>
      <!-- <d each={recipe.inputs}></d> -->
      <h6>Recipe inputs:</h6>
      <strong>ingredients, <strong>{otherInputs} <span if={otherInputs.length > 1}>,</span> </strong> </strong><button class="btn plusInput" onclick={newInput} if={!newinputtoggle}> <i class="fa fa-plus" aria-hidden="true"></i> </button>

      <input ref="newInput" if={newinputtoggle} onfocusout={addNewInput} type="text" placeholder="newInputHere">

      <strong></strong>

    </div>
  </div>
  <div class="row">
    <div class="col">
      <p>print(Each step should be typed inside the print(); function)</p>

    </div>
  </div>
  <div class="row">
    <div class="col">
      <textarea class="form-control" ref="stepsinput" onkeyup={transferText} ondrop={parseQty}></textarea>
    </div>
    <div class="col">
      <div class="textOutput" ref="output">
        <!-- {output} -->
        </ol>
      </div>
      <button type="button" class="btn" id="savebtn" onclick={saveRecipe}>Save Recipe</button>
    </div>
  </div>



<script>
   var that = this;
   that.newinputtoggle = false;
   that.otherInputs = [];
   that.user = firebase.auth().currentUser;

   that.transferText = function() {
     var input = that.refs.stepsinput.value;
     input = that.changeQtyToNumber(input);
     input = that.checkForEnters(input);
     that.refs.output.innerHTML = input;
   }

   that.data;
   that.changeQtyToNumber = function(str) {
     var newString = "<ol><li>";
     var arr = str.split("qty");
     for (var substr of arr) {
       if (substr.endsWith(".")) {
         substr = substr.slice(0, substr.length-1);
         var lastIndex = substr.lastIndexOf(" ") + 1;
         var ingrName = substr.slice(lastIndex, substr.length);
         var ingrRef = firebase.database().ref(`recipes/${that.parent.newRecipe.id}/inputs/ingredients/${ingrName}/qty`);

         ingrRef.on('value',function(snapshot) {
           that.data = snapshot.val();
         })
         substr = substr.replace(`${ingrName}`, `${that.data}`);
         newString += substr;
       } else {
         newString += substr;
       }
     }
     return newString;
   }

   that.checkForEnters = function(str) {
     if (str.includes('\n')) {
       str = str.split('\n').join('</li><li>');
       return str;
     } else {
       return str;
     }
   }

   that.newInput = function() {
     that.newinputtoggle = true;
   }

   that.addNewInput = function() {
     var newInput = that.refs.newInput.value;
     if (newInput == null || newInput == " ") {
       that.newInputToggle = false;
       return;
     }
       var ref = firebase.database().ref(`recipes/${that.parent.newRecipe.id}/inputs/${newInput}`);
       ref.set(newInput);
       that.otherInputs.push(newInput);
       that.newinputtoggle = false;
   }

   that.currentQty;

   that.startDrag = function(e){
     var draggedIngr = e.srcElement.firstElementChild.childNodes[0].innerHTML;
     var x = `${draggedIngr}.qty`;
     // that.getCurrentQty(draggedIngr);
     e.dataTransfer.setData('Text', x);
   }

   that.parseQty = function(e){
     var x = e.dataTransfer.getData('Text');
   }

   that.dropped = function(e) {
     // e.preventDefault();
   }

   that.on('update', function(){
     var ingrAr = that.parent.refs.ingrToDrag;
     for (var i of ingrAr) {
       i.addEventListener("dragstart", that.startDrag, false);
     }
     that.refs.stepsinput.addEventListener("dragenter", function(e){e.preventDefault;}, false);
     that.refs.stepsinput.addEventListener("dragover", function(e){e.preventDefault;}, false);
     that.refs.stepsinput.addEventListener("drop", that.dropped, false);
   })

   that.saveRecipe = function() {
     console.log("it works");
     var codetext = that.refs.stepsinput.value;
     var coderef = firebase.database().ref(`recipes/${that.parent.newRecipe.id}/codetext`);
     coderef.set(codetext);

     var printtext = that.refs.output.innerHTML;
     var printref = firebase.database().ref(`recipes/${that.parent.newRecipe.id}/printtext`);
     printref.set(printtext);
     that.copyToPrivate();
   }

   that.recipedata;
   that.copyToPrivate = function() {
     var uid = that.user.uid;
     var reciperef = firebase.database().ref(`recipes/${that.parent.newRecipe.id}`);
     reciperef.once('value', function(snapshot){
       that.recipedata = snapshot.val();
       that.update();
     });

     var privateref = firebase.database().ref(`private/${that.user.uid}/myrecipes/${that.parent.newRecipe.id}`);
     privateref.set(that.recipedata);
   }

</script>

<style>
  .textInput {
    margin: 5px 0px 5px 0px;
  }
  .textOutput {
    margin: 5px 0px 5px 0px;
    background-color: rgba(255,255,255, 0.6);
    padding: 3px;
    overflow: auto;
    height: 85%;
  }
  step-input {
    margin: 15px 0px 0px 20px;
    display: block;
  }
  .plusInput {
    color: white;
    padding: 3px 5px 3px 5px;
    /*height: 20px;*/
  }
  .fa-plus {
    font-size: 12px;
    margin-top: -10px;
  }
  .fa-plus-circle {
    color:teal;
    border-radius: 50%;
  }
  ol {
    counter-reset: item;
    padding-left: 10px;
  }
  ol li {
    display: block;
  }
  ol li:before {
    content: counter(item) ". ";
    counter-increment: item;
    color: teal;
  }
  #savebtn {
    background-color: palegoldenrod;
    color: black;
    float:right;
  }

</style>

</write-recipe>
