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
    @already_favorited = TunesTakeoutWrapper.get_favorites(current_user.uid)["suggestions"]
  end

  def favorite
    status_code = TunesTakeoutWrapper.favorite(current_user.uid, params[:id])

    if status_code == 201
      flash[:notice] = "Your favorite was successfully added."
    elsif status_code == 409
      flash[:error] = "This suggestion has already been favorited."
    else
      flash[:error] = "That is not a valid suggestion."
    end

    redirect_to favorites_suggestions_path
  end

  def unfavorite
    status_code = TunesTakeoutWrapper.unfavorite(current_user.uid, params[:id])

    if status_code == 204
      flash[:notice] = "You successfully removed this favorite."
    else
      flash[:error] = "There was an error with your request to unfavorite a suggestion."
    end

    redirect_to favorites_suggestions_path
  end

  def favorites
    @already_favorited = TunesTakeoutWrapper.get_favorites(current_user.uid)["suggestions"]
    @suggestions = get_suggestions_from_ids(@already_favorited)

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
