require 'yelp'
require 'uri'

class Food
  BASE_URL = "https://api.yelp.com/"
  attr_reader :name, :url, :rating, :address, :phone, :image_url

  def initialize(data)
    @name = data.business.name
    @url = data.business.url
    @rating = data.business.rating_img_url_large
    @address = data.business.location.display_address
    @phone = data.business.display_phone
    @image_url = data.business.image_url
  end

  # yelp business API
  def self.business(suggestions_array)
    suggestions_array.map do |suggestion|
      uri_escaped = URI.escape(suggestion["food_id"])
      new(Yelp.client.business(uri_escaped))
    end
  end
end

