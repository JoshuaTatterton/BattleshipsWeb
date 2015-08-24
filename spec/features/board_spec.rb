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
  let(:destroyer) { double :ship, size: 1, board_rep: :d }
  let(:carrier) { double :ship, size: 5, board_rep: :a}
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
  end
end