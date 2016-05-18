require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"

  def self.top_suggestions
    HTTParty.get(BASE_URL + "/v1/suggestions/top").parsed_response
  end

  # suggestions = TunesTakeoutWrapper.search("avocado")["suggestions"]
  # find a suggestion based on a query and optional limit
  def self.search(query, limit = 10, seed = query)
    HTTParty.get(BASE_URL + "v1/suggestions/search?query=#{query}&limit=#{limit}&seed=#{query}").parsed_response
  end

  # retrieve a suggestion
  def self.retrieve(id)
    HTTParty.get(BASE_URL + "/v1/suggestions/#{id}").parsed_response
  end
end