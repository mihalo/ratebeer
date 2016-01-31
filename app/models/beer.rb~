class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

def average_rating
  ar = self.ratings
  score = 0

    ar.each do |i|
      score = score + i.score
    end

  score/ar.length
end

end
