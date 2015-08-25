require "spec_helper"

describe Board do
  context "creates and stores a board" do
    it "can display the players board" do
      expect(subject).to respond_to (:view_board)
    end
    it "has a board full of water when created" do
      expect(subject.view_board).to match_array(Array.new(10) { Array.new(10) { :w } } )
    end
  end
  let(:destroyer) { double :ship, size: 1, board_rep: :d, sunk?: true, hit: nil, setV: "", setH: "" }
  let(:carrier) { double :ship, size: 5, board_rep: :a, sunk?: false, hit: nil, setV: "", setH: "" }
  context "can place ships on the board" do
    it { is_expected.to respond_to(:place_ship).with(3).argument }
    it "can place single section ships" do
      subject.place_ship(destroyer, :A1, :horizontal)
      expect(subject.view_board[0][0]).to eq :d
    end
    it "will not let ships overlap" do
      subject.place_ship(destroyer, :A2, :horizontal)
      expect { subject.place_ship(carrier, :A1, :vertical) }.to raise_error "Ship already at location"
    end
    it "can place multi section ships" do
      subject.place_ship(carrier, :A1, :vertical)
      expect(subject.view_board[0][0]).to eq :a
      expect(subject.view_board[1][0]).to eq :a
      expect(subject.view_board[2][0]).to eq :a
      expect(subject.view_board[3][0]).to eq :a
      expect(subject.view_board[4][0]).to eq :a
    end
    it "cannot place ships outside of the board" do
      expect { subject.place_ship(carrier,:I9,:vertical) }.to raise_error "Out of bounds"
    end
    it "tells the ship where it has been placed" do
      ship = spy :ship, size: 5, board_rep: :a
      subject.place_ship(ship,:A1,:vertical)
      expect(ship).to have_received(:setV)
      subject.place_ship(ship,:B1,:horizontal)
      expect(ship).to have_received(:setH)
    end
    it "keeps a record of what ships are placed on the board" do
      subject.place_ship(carrier,:A1,:vertical)
      expect(subject.ships[:a]).to eq carrier
    end
  end
  context "firing on the board" do
    it { is_expected.to respond_to(:fire).with(1).argument }
    it "changes the value on the board to m if miss" do
      subject.fire(:A1)
      expect(subject.view_board[0][0]).to eq :m
    end
    it "cannot fire at location twice" do 
      subject.fire(:A1)
      expect { subject.fire(:A1) }.to raise_error "Already fired at location"
    end
    it "reports miss if empty space" do
      expect(subject.fire(:A1)).to eq :miss
    end
    it "reports hit if ship there" do
      subject.place_ship(carrier,:A1,:horizontal)
      expect(subject.fire(:A1)).to eq :hit
    end
    it "changes the value on the board to h if miss" do
      subject.place_ship(carrier,:A1,:horizontal)
      subject.fire(:A1)
      expect(subject.view_board[0][0]).to eq :h
    end
    it "tells the ship where to be hit" do
      ship = spy :ship, size: 5, board_rep: :a, sunk?: false 
      subject.place_ship(ship,:A1,:horizontal)
      subject.fire(:A1)
      expect(ship).to have_received(:hit)
    end
    it "reports hit if ship there" do
      subject.place_ship(destroyer,:A1,:horizontal)
      expect(subject.fire(:A1)).to eq :sunk
    end
  end
end