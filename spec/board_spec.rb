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
end