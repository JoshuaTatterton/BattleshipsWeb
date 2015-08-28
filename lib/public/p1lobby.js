var myVar = setInterval(function () {
  
  $.get("/online/pvp/p1/turn", function(turn) {
    if(turn===null) {
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
  });
}, 3000);