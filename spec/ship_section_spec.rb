require "spec_helper"

describe Ship_Section do
  it { is_expected.to respond_to(:hit?)}
  it "should be able to be hit" do
    subject.hit
    expect(subject.hit?).to eq true
  end
  it { is_expected.to respond_to(:location) }
  it "should be able to set its location" do 
    subject.set(:A1)
    expect(subject.location).to eq :A1
  end
end