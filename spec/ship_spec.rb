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
    it { expect(Ship).to respond_to (:destroyer) }
    it "cruiser size = 2" do 
      expect(Ship::CRUISER_SIZE).to eq 2
    end
    it { expect(Ship).to respond_to (:cruiser) }
    it "submarine size = 3" do 
      expect(Ship::SUBMARINE_SIZE).to eq 3
    end
    it { expect(Ship).to respond_to (:submarine) }
    it "battleship size = 4" do 
      expect(Ship::BATTLESHIP_SIZE).to eq 4
    end
    it { expect(Ship).to respond_to (:battleship) }
    it "aircraft carrier size = 5" do 
      expect(Ship::AIRCRAFT_CARRIER_SIZE).to eq 5
    end
    it { expect(Ship).to respond_to (:aircraft_carrier) }
  end
end