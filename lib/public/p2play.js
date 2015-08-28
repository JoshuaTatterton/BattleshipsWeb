var myVar = setInterval(function () {
  
  $.get("/online/pvp/p2/turn", function(turn) {
    console.log($("#hiddenID").val())
    if(turn===$("#hiddenID").val()) {
      $("#tickTock").text("");
      $("#waiting").text("Please select where to fire");
      $.get("/online/pvp/p2/board", function(board) { 
        $("#ownBoard").text(board);
      });
      $("#location").removeClass("hidden");
      $("#fire").removeClass("hidden");
      clearInterval(myVar);
    } else {
      if($("#tickTock").text()==="...") {
        $("#tickTock").text("");
      } else {
        $("#tickTock").text($("#tickTock").text()+".");
      }
    }

  });

}, 3000);