class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: {with: /[A-Z]+/}

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.joins(:beer).group(:style).average(:score).max_by { |k, v| v }.first
  end

  def favorite_brewery
    return nil if ratings.empty?
    ratings.group_by { |r| r.beer.brewery }.map {
        |k, v| [k, sequence_rating_average(v)]
    }.max_by { |k, v| v }.first
  end

  def sequence_rating_average(ratings)
    return nil if ratings.empty?
    ratings.inject(0.0) { |sum, r| sum+r.score } / ratings.count
  end

end
