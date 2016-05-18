require 'yelp'

class Food
  BASE_URL = "https://api.yelp.com/"

  # yelp business API
  def self.business(id)
    business = Yelp.client.business(id)
  end
end
