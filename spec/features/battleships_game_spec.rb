require "spec_helper"

describe "Features" do

  let(:board) { Board.new }
  let(:destroyer) { Ship.destroyer }
  let(:cruiser) { Ship.cruiser }
  let(:submarine) { Ship.submarine }
  let(:battleship) { Ship.battleship }
  let(:aircraft_carrier) { Ship.aircraft_carrier }
  let(:section) { Ship_Section.new }
  describe Ship do
    context "can create ships using ship names" do
      it "Destroyer" do
        expect(destroyer.size).to eq Ship::DESTROYER_SIZE
      end
      it "Cruiser" do
        expect(cruiser.size).to eq Ship::CRUISER_SIZE
      end
      it "Submarine" do
        expect(submarine.size).to eq Ship::SUBMARINE_SIZE
      end
      it "Battleship" do
        expect(battleship.size).to eq Ship::BATTLESHIP_SIZE
      end
      it "Aircraft Carrier" do
        expect(aircraft_carrier.size).to eq Ship::AIRCRAFT_CARRIER_SIZE
      end
    end
    context "ships are created containing the amount of ship sections" do
      it "Destroyer" do 
        destroyer.ship.each { |s| expect(s).to be_an_instance_of(Ship_Section) }
      end
      it "Cruiser" do 
        cruiser.ship.each { |s| expect(s).to be_an_instance_of(Ship_Section) }
      end
      it "Submarine" do 
        submarine.ship.each { |s| expect(s).to be_an_instance_of(Ship_Section) }
      end
      it "Battleship" do 
        battleship.ship.each { |s| expect(s).to be_an_instance_of(Ship_Section) }
      end
      it "Aircraft Carrier" do 
        aircraft_carrier.ship.each { |s| expect(s).to be_an_instance_of(Ship_Section) }
      end
    end
    context "Ships have a symbol to be represented as on the board" do
      it "Destroyer" do 
        expect(destroyer.board_rep).to eq :d
      end
      it "Cruiser" do 
        expect(cruiser.board_rep).to eq :c
      end
      it "Submarine" do 
        expect(submarine.board_rep).to eq :s
      end
      it "Battleship" do 
        expect(battleship.board_rep).to eq :b
      end
      it "Aircraft Carrier" do 
        expect(aircraft_carrier.board_rep).to eq :a
      end
    end
  end

  describe Board do
    it "creates a 10x10 board full of water" do
      expect(board.view_board).to eq (Array.new(10) { Array.new(10) { :w } })
    end
    it "can place ships on the board" do
      expect { board.place_ship(destroyer,:B1,:horizontal) }.not_to raise_error
      expect(board.view_board[0][1]).to eq :d
      expect { board.place_ship(cruiser,:A1,:horizontal) }.to raise_error "Ship already at location"
      expect { board.place_ship(submarine,:D4,:horizontal) }.not_to raise_error
      expect(board.view_board[3][3]).to eq :s
      expect(board.view_board[3][4]).to eq :s
      expect(board.view_board[3][5]).to eq :s
      expect { board.place_ship(battleship,:A0, :horizontal) }.to raise_error "Out of bounds"
      expect { board.place_ship(aircraft_carrier,:J10, :horizontal) }.to raise_error "Out of bounds"
    end
    it "ships know where they are after being placed on board" do
      board.place_ship(battleship,:B2,:vertical)
      expect(battleship.ship[0].location).to eq :B2
      expect(battleship.ship[1].location).to eq :B3
      expect(battleship.ship[2].location).to eq :B4
      expect(battleship.ship[3].location).to eq :B5
      board.place_ship(aircraft_carrier,:C2,:horizontal)
      expect(aircraft_carrier.ship[0].location).to eq :C2
      expect(aircraft_carrier.ship[1].location).to eq :D2
      expect(aircraft_carrier.ship[2].location).to eq :E2
      expect(aircraft_carrier.ship[3].location).to eq :F2
      expect(aircraft_carrier.ship[4].location).to eq :G2
    end
    context "can fire at the board" do
      before(:each) { board.place_ship(cruiser,:A1,:vertical) }
      it "" do
        expect { board.fire(:D4) }.not_to raise_error
        expect(board.view_board[3][3]).to eq :m
        expect { board.fire(:D4) }.to raise_error "Already fired at location"
      end
      it "misses" do
        expect(board.fire(:A3)).to eq :miss
        expect(board.view_board[2][0]).to eq :m
      end
      it "hits" do
        expect(board.fire(:A1)).to eq :hit
        expect(board.view_board[0][0]).to eq :h 
        expect(cruiser.ship[0]).to be_hit
      end
      it "sinks" do
        board.fire(:A1)
        expect(board.fire(:A2)).to eq :sunk
        expect(board.view_board[1][0]).to eq :h 
        expect(cruiser).to be_sunk
      end
    end
  end
  describe Ship_Section do
    context "knows if it has been hit or not" do
      it "should initially be not hit" do
        expect(section).not_to be_hit
      end
      it "should be hit after being hit" do
        section.hit
        expect(section).to be_hit
      end
      it "should store its location when set" do
        section.set(:A1)
        expect(section.location).to eq :A1
      end
    end
  end
end