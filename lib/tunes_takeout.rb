require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"

  def self.search(query, limit = 10, seed = query)
    HTTParty.get(BASE_URL + "v1/suggestions/search?query=#{query}&limit=#{limit}&seed=#{query}")
  end

end