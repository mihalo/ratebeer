require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one is returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1), Place.new(name: "Baari", id: 2)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Baari"
  end

  it "if none is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("empty").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'empty')
    click_button "Search"

    expect(page).to have_content "No locations in empty"

  end
end