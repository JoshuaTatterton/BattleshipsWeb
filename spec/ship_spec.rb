require "spec_helper"

describe Ship do 
  let(:subject) { Ship.new(1,:d) }
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
      it "Destroyer has 1" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.destroyer.ship).to match_array(Array.new(Ship::DESTROYER_SIZE) { section })
      end
      it "Cruiser has 2" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.cruiser.ship).to match_array(Array.new(Ship::CRUISER_SIZE) { section })
      end
      it "Submarine has 3" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.submarine.ship).to match_array(Array.new(Ship::SUBMARINE_SIZE) { section })
      end
      it "Battleship has 4" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.battleship.ship).to match_array(Array.new(Ship::BATTLESHIP_SIZE) { section })
      end
      it "Aircraft Carrier has 5" do
        allow(Ship_Section).to receive(:new) { section }
        expect(Ship.aircraft_carrier.ship).to match_array(Array.new(Ship::AIRCRAFT_CARRIER_SIZE) { section })
      end
    end
  end
  context "has different symbols to represent each ship" do
    it "can read the ship symbol" do
      expect(subject).to respond_to (:board_rep)
    end
    it "Destroyer = d" do
      expect(Ship.destroyer.board_rep).to eq :d
    end
    it "Cruiser = c" do
      expect(Ship.cruiser.board_rep).to eq :c
    end
    it "Submarine = s" do
      expect(Ship.submarine.board_rep).to eq :s
    end
    it "Battleship = b" do
      expect(Ship.battleship.board_rep).to eq :b
    end
    it "Aircraft Carrier = a" do
      expect(Ship.aircraft_carrier.board_rep).to eq :a
    end
  end
  context "it sets its location" do
    it { is_expected.to respond_to(:setV).with(1).argument }
    it { is_expected.to respond_to(:setH).with(1).argument }
    it "tells the ship sections where they are" do 
      section = spy :section
      allow(Ship_Section).to receive(:new) { section }
      ship = Ship.new(2,:c).setV(:A1)
      expect(section).to have_received(:set).at_least(2).times
      Ship.new(2,:c).setH(:A1)
      expect(section).to have_received(:set).at_least(2).times
    end
  end
  context "can be hit," do
    it "hits a section" do
      section = spy :section, location: :A1
      allow(Ship_Section).to receive(:new) { section }
      ship = Ship.new(1,:d)
      ship.hit(:A1)
      expect(section).to have_received(:hit)
    end
    it "doesn't hit if not at location" do
      section = spy :section, location: :A1
      allow(Ship_Section).to receive(:new) { section }
      ship = Ship.new(1,:d)
      ship.hit(:A2)
      expect(section).not_to have_received(:hit)
    end
    it { is_expected.to respond_to(:sunk?) }
    it "it returns not sunk when not sunk duuhh" do
      section = double :section, hit?: false
      allow(Ship_Section).to receive(:new) { section }
      ship = Ship.new(3,:s)
      expect(ship).not_to be_sunk
    end
    it "knows when it has been sunk" do
      section = double :section, hit?: true
      allow(Ship_Section).to receive(:new) { section }
      ship = Ship.new(3,:s)
      expect(ship).to be_sunk
    end
  end
end