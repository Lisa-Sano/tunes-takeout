require 'tunes_takeout'

class SuggestionsController < ApplicationController

  def index
    if current_user && params[:query].present?
      @suggestions = TunesTakeoutWrapper.search(params[:query], params[:limit])["suggestions"]
      @title = "Search Results"
    else
      suggestion_ids = TunesTakeoutWrapper.top_suggestions["suggestions"]
      @suggestions = get_suggestions_from_ids(suggestion_ids)
      @title = "Top 20 Suggestions"
    end

    @food, @music = get_food_and_music(@suggestions)
  end

  def favorite
    TunesTakeoutWrapper.favorite(current_user.uid, params[:id])
    redirect_to suggestions_path
  end

  def unfavorite
    TunesTakeoutWrapper.unfavorite(current_user.uid, params[:id])
    redirect_to favorites_suggestions_path
  end

  def favorites
    suggestion_ids = TunesTakeoutWrapper.get_favorites(current_user.uid)["suggestions"]
    @suggestions = get_suggestions_from_ids(suggestion_ids)

    @food, @music = get_food_and_music(@suggestions)
  end

  private

  def get_suggestions_from_ids(id_array)
    id_array.map { |id| TunesTakeoutWrapper.retrieve(id)["suggestion"] }
  end

  def get_food_and_music(suggestions_array)
    [Food.business(suggestions_array), Music.find(suggestions_array)]
  end
end
