var myVar = setInterval(function () {
  
  $.get("/online/pvp/player/turn", function(turn) {
    if(turn===$("#hiddenID").val()) {
      $("#tickTock").text("");
      $("#start").removeClass("hidden");
      clearInterval(myVar);
    } else {
      if($("#tickTock").text()===" ...") {
        $("#tickTock").text(" ");
      } else {
        $("#tickTock").text($("#tickTock").text()+".");
      }
    }
  });
}, 3000);