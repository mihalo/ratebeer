require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is saved with correct name and style" do
    beer = Beer.create name: "test beer", style: "test style"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without name" do
    beer = Beer.create style: "test style"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    beer = Beer.create name: "test beer"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
