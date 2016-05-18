require 'yelp'

class Food
  BASE_URL = "https://api.yelp.com/"

  # yelp business API
  def self.business(suggestions_array)
    suggestions_array.map do |suggestion|
      Yelp.client.business(suggestion["food_id"])
    end
  end
end
