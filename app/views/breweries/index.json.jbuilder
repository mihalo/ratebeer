json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year

  json.beers_count do
    json.beers_count Beer.where(:brewery_id => brewery.id).count
  end

end
