require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end


  it "is created if name is not empty" do
    visit new_beer_path
    fill_in('beer[name]', with: 'Olut')

    expect {
      click_button "Create Beer"
    }.to change { Beer.count }.from(0).to(1)

    expect(Beer.count).to eq(1)

  end

  it "is not created if name is empty" do
    visit new_beer_path
    click_button "Create Beer"

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end

end