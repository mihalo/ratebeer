module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    if ratings.count == 0
      return 0
    end
    ratings.map{ |r| r.score }.sum / ratings.count.to_f
  end

end
