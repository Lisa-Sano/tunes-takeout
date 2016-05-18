require 'rspotify'

class Music
  
  def self.find(id, type, user_id = nil)
    if type == "artist"
      RSpotify::Artist.find(id)
    elsif type == "album"
      RSpotify::Album.find(id)
    elsif type == "track"
      RSpotify::Track.find(id)
    elsif type == "playlist"
      RSpotify::Playlist.find(user_id, id)
    end
  end
end
