require 'tunes_takeout'

class SuggestionsController < ApplicationController

  def index
    if current_user && params[:query].present?
      @suggestions = TunesTakeoutWrapper.search(params[:query], params[:limit])["suggestions"]
      @title = "Search Results"
    else
      suggestion_ids = TunesTakeoutWrapper.top_suggestions["suggestions"]
      @suggestions = suggestion_ids.map { |id| TunesTakeoutWrapper.retrieve(id)["suggestion"] }
      @title = "Top 20 Suggestions"
    end

    @food = Food.business(@suggestions)
    @music = Music.find(@suggestions)
  end


end
