require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"

  def self.top_suggestions(limit = 20)
    HTTParty.get(BASE_URL + "/v1/suggestions/top?limit=#{limit}").parsed_response
  end

  # suggestions = TunesTakeoutWrapper.search("avocado")["suggestions"]
  # find a suggestion based on a query and optional limit
  def self.search(query, limit = 10, seed = query)
    HTTParty.get(BASE_URL + "v1/suggestions/search?query=#{query}&limit=#{limit}&seed=#{query}").parsed_response
  end

  # retrieve a suggestion
  def self.retrieve(id)
    HTTParty.get(BASE_URL + "v1/suggestions/#{id}").parsed_response
  end

  # favorite a suggestion
  def self.favorite(user_id, suggestion_id)
    HTTParty.post(BASE_URL + "v1/users/#{user_id}/favorites", 
      :body => { "suggestion": "#{suggestion_id}" }.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
  end

  # get a user's list of favorites
  def self.get_favorites(user_id)
    HTTParty.get(BASE_URL + "v1/users/#{user_id}/favorites").parsed_response
  end

  def self.unfavorite(user_id, suggestion_id)
    HTTParty.delete(BASE_URL + "v1/users/#{user_id}/favorites", 
      :body => { "suggestion": "#{suggestion_id}" }.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
  end
end