class Brewery < ActiveRecord::Base
  has_many :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end
end
