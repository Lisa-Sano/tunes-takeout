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

  def favorite
    TunesTakeoutWrapper.favorite(current_user.uid, params[:id])
    redirect_to suggestions_path
  end

  def favorites
    suggestion_ids = TunesTakeoutWrapper.get_favorites(current_user.uid)["suggestions"]
    @suggestions = suggestion_ids.map { |id| TunesTakeoutWrapper.retrieve(id)["suggestion"] }

    @food = Food.business(@suggestions)
    @music = Music.find(@suggestions)
  end
end
