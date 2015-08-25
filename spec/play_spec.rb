require "spec_helper"

describe Play do
  let(:p1board) { double :p1board }
  let(:p2board) { double :p2board }
  let(:ship) { double :ship }
  let(:spy_board) { spy :board }
  context "initializes with" do
    it "Player 1 board ready to use" do
      allow(Board).to receive(:new) { p1board }
      expect(subject.player1_board).to eq p1board
    end
    it "Player 2 board ready to use" do
      allow(Board).to receive(:new) { p2board }
      expect(subject.player2_board).to eq p2board
    end
  end
  context "lets players place ships on the board" do
    it "Player 1" do
      allow(Board).to receive(:new) { spy_board }
      subject.player1_place(ship,:A1,:vertical)
      expect(spy_board).to have_received(:place_ship)
    end
    it "Player 2" do
      allow(Board).to receive(:new) { spy_board }
      subject.player2_place(ship,:A1,:vertical)
      expect(spy_board).to have_received(:place_ship)
    end
  end
  context "lets players fire at the opponents board" do
    it "Player 1" do
      allow(Board).to receive(:new) { spy_board }
      subject.player1_fire(:A1)
      expect(spy_board).to have_received(:fire)
    end
    it "Player 2" do
      allow(Board).to receive(:new) { spy_board }
      subject.player2_fire(:A1)
      expect(spy_board).to have_received(:fire)
    end
  end
  context "knows when player has won" do
    it "Player 1" do
      allow(Board).to receive(:new) { spy_board }
      allow(spy_board).to receive(:fire) { :sunk }
      subject.player1_fire(:A1)
      expect(spy_board).to have_received(:winner?)
    end
    it "Player 2" do
      allow(Board).to receive(:new) { spy_board }
      allow(spy_board).to receive(:fire) { :sunk }
      subject.player2_fire(:A1)
      expect(spy_board).to have_received(:winner?)
    end
  end
end