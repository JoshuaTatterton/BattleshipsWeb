require "spec_helper"

describe Ship do 
  let(:subject) { Ship.new(1) }
  it "can read the size of the ships" do
    expect(subject).to respond_to(:size)
  end
  context "it has default sizes for different ship types" do
    it "destroyer size = 1" do
      expect(Ship::DESTROYER_SIZE).to eq 1
    end
    it "cruiser size = 2" do 
      expect(Ship::CRUISER_SIZE).to eq 2
    end
    it "submarine size = 3" do 
      expect(Ship::SUBMARINE_SIZE).to eq 3
    end
    it "battleship size = 4" do 
      expect(Ship::BATTLESHIP_SIZE).to eq 4
    end
    it "aircraft carrier size = 5" do 
      expect(Ship::AIRCRAFT_CARRIER_SIZE).to eq 5
    end
  end
  context "can create different types of ships" do
    it { expect(Ship).to respond_to (:destroyer) }
    it { expect(Ship).to respond_to (:cruiser) }
    it { expect(Ship).to respond_to (:submarine) }
    it { expect(Ship).to respond_to (:battleship) }
    it { expect(Ship).to respond_to (:aircraft_carrier) }
  end
  context "is made up of its size parts" do
    it "can read the sections of the ship" do
      expect(subject).to respond_to (:ship)
    end
    context "the different sections should be part of the ship_section class" do 
      let(:section) { double :section }
      it "Destroyers" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.destroyer.ship).to match_array(Array.new(Ship::DESTROYER_SIZE) { section })
      end
      it "Cruisers" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.cruiser.ship).to match_array(Array.new(Ship::CRUISER_SIZE) { section })
      end
      it "Submarine" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.submarine.ship).to match_array(Array.new(Ship::SUBMARINE_SIZE) { section })
      end
      it "Battleship" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.battleship.ship).to match_array(Array.new(Ship::BATTLESHIP_SIZE) { section })
      end
      it "Aircraft Carrier" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.aircraft_carrier.ship).to match_array(Array.new(Ship::AIRCRAFT_CARRIER_SIZE) { section })
      end
    end
  end
end