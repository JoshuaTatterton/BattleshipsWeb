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
  end

  describe Board do
    it "creates a 10x10 board full of water" do
      expect(board.view_board).to eq (Array.new(10) { Array.new(10) { "w" } })
    end
  end
end