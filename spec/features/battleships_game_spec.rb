require "spec_helper"

describe "Features" do
  let(:board) { Board.new }
  let(:ship) { Ship.new }
  describe Ship do
    context "can create ships using ship names" do
      it "Destroyer" do
        ship = Ship.destroyer
        expect(ship.size).to eq Ship::DESTROYER_SIZE
      end
      it "Cruiser" do
        ship = Ship.cruiser
        expect(ship.size).to eq Ship::CRUISER_SIZE
      end
      it "Submarine" do
        ship = Ship.submarine
        expect(ship.size).to eq Ship::SUBMARINE_SIZE
      end
      it "Battleship" do
        ship = Ship.battleship
        expect(ship.size).to eq Ship::BATTLESHIP_SIZE
      end
      it "Aircraft Carrier" do
        ship = Ship.aircraft_carrier
        expect(ship.size).to eq Ship::AIRCRAFT_CARRIER_SIZE
      end
    end
  end
end