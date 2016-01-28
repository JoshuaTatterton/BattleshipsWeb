var myVar = setInterval(function () {
  
  $.get("/online/pvp/player/turn", function(turn) {

    var fillPage = function() {
      $("#tickTock").text("");
      $("#waiting").text("Please select where to fire");
      $.get("/online/pvp/p2/board", function(board) { 
        $("#ownBoard").text(board);
      });
      $("#ownBoard").removeClass("hidden");
      $("#ownBoard").addClass("board");
      $("#location").removeClass("hidden");
      $("#fire").removeClass("hidden");
    };
    if(turn===$("#hiddenID").val()) {
      $.get("/online/pvp/last/move", function(move) {
        $.get("/online/pvp/last/status", function(status) {
          if(status==="miss") {
            fillPage();
            $("#playermessage").removeClass("hidden");
            $("#message").text(" has missed firing at "+move);
          } else if(status==="hit") {
            fillPage();
            $("#playermessage").removeClass("hidden");
            $("#message").text(" has hit your ship firing at "+move);
          } else if(status==="sunk") {
            fillPage();
            $("#playermessage").removeClass("hidden");
            $("#message").text(" has sunk your ship firing at "+move);
          } else if(status==="winner") {
            $("#playermessage").removeClass("hidden");
            $("#message").text(" has sunk your final ship, you lose!");
            $("#menu").removeClass("hidden");
          } else {
            fillPage();
          }
        });
      });
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