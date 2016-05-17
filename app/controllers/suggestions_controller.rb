require 'tunes_takeout'

class SuggestionsController < ApplicationController
  extend TunesTakeoutWrapper

  def index
    @suggestions = TunesTakeoutWrapper.search(params[:query])
  end
end
