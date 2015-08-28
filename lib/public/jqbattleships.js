$(document).ready(function() {

  var placeShip = function(type,location,direction) {
    $.get("/online/pvp/p1/"+type+"/"+location+"/"+direction, "", function() {
      $.get("/online/pvp/p1/board", function(board) { 
        $("#board").text(board);
      });
    })
  };
  var placeShip2 = function(type,location,direction) {
    $.get("/online/pvp/p2/"+type+"/"+location+"/"+direction, "", function() {
      $.get("/online/pvp/p2/board", function(board) { 
        $("#board").text(board);
      });
    })
  };

  $("#place").click(function() {
    if($("#ship").text()==="Aircraft Carrier(5):") {
      placeShip("aircraft_carrier",$("#location").val(),$("#direction").val())
      $("#ship").text("Battleship(4):");
    } else if($("#ship").text()==="Battleship(4):") {
      placeShip("battleship",$("#location").val(),$("#direction").val())
      $("#ship").text("Submarine(3):");
    } else if($("#ship").text()==="Submarine(3):") {
      placeShip("submarine",$("#location").val(),$("#direction").val())
      $("#ship").text("Cruiser(2):");
    } else if($("#ship").text()==="Cruiser(2):") {
      placeShip("cruiser",$("#location").val(),$("#direction").val())
      $("#ship").text("Destroyer(1):");
      $("#place").hide();
      $("#place_final").removeClass("hidden");
    }
  });

  $("#place2").click(function() {
    if($("#ship").text()==="Aircraft Carrier(5):") {
      placeShip2("aircraft_carrier",$("#location").val(),$("#direction").val())
      $("#ship").text("Battleship(4):");
    } else if($("#ship").text()==="Battleship(4):") {
      placeShip2("battleship",$("#location").val(),$("#direction").val())
      $("#ship").text("Submarine(3):");
    } else if($("#ship").text()==="Submarine(3):") {
      placeShip2("submarine",$("#location").val(),$("#direction").val())
      $("#ship").text("Cruiser(2):");
    } else if($("#ship").text()==="Cruiser(2):") {
      placeShip2("cruiser",$("#location").val(),$("#direction").val())
      $("#ship").text("Destroyer(1):");
      $("#place2").hide();
      $("#place_final").removeClass("hidden");
    }
  });

});