require "spec_helper"

describe "Features" do

  let(:board) { Board.new }
  let(:destroyer) { Ship.destroyer }
  let(:cruiser) { Ship.cruiser }
  let(:submarine) { Ship.submarine }
  let(:battleship) { Ship.battleship }
  let(:aircraft_carrier) { Ship.aircraft_carrier }

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
      expect { board.place_ship(destroyer,:A1, :hoizontal) }.not_to raise_error
      expect(board.view_board[0,0]).to eq :d
      expect { board.place_ship(cruiser,:A1, :hoizontal) }.to raise_error "Ship already at location"
      expect { board.place_ship(submarine,:D4, :vertical) }.not_to raise_error
      expect(board.view_board[0,3..5]).to eq :s
      expect { board.place_ship(battleship,:A0, :hoizontal) }.to raise_error "Out of bounds"
      expect { board.place_ship(aircraft_carrier,:J10, :hoizontal) }.to raise_error "Out of bounds"
    end
  end
end