var myVar = setInterval(function () {
  
  var turn = $.get("/online/pvp/p1/turn")
  if(turn.responceText===undefined) {
    if($("#tickTock").text()==="...") {
      $("#tickTock").text("");
    } else {
      $("#tickTock").text($("#tickTock").text()+".");
    }
  } else {
    $("#tickTock").text("");
    $("#start").removeClass("hidden");
    clearInterval(myVar);
  }
}, 3000);