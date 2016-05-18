require 'rspotify'

class Music
  
  def self.find(suggestion_array)
    suggestion_array.map do |suggestion|
      if suggestion["music_type"] == "artist"
        RSpotify::Artist.find(suggestion["music_id"])
      elsif suggestion["music_type"] == "album"
        RSpotify::Album.find(suggestion["music_id"])
      elsif suggestion["music_type"] == "track"
        RSpotify::Track.find(suggestion["music_id"])
      end
    end
  end
end
