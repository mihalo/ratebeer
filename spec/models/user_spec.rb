require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username: "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username: "Pekka", password: "aa", password_confirmation: "aa"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)

  end

  it "is not saved if password don't contain any integers" do
    user = User.create username: "Pekka", password: "aaaa", password_confirmation: "aaaa"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  def create_beer_with_rating(user, score = 10, style = "Lager", brewery = nil)
    if brewery
      beer = FactoryGirl.create(:beer, brewery: brewery, style: style)
    else
      beer = FactoryGirl.create(:beer, style: style)
    end
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating(user, score)
    end
  end

  describe "ravorite style" do
    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating average of beers rated" do
      create_beers_with_ratings(user, 1, 1, 50)
      best = create_beer_with_rating(user, 40, "IPA")

      expect(user.favorite_style).to eq(best.style)
    end

  end


end
