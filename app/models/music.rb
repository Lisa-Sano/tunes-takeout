require 'rspotify'

class Music
  attr_reader :name, :url, :type, :image

  def initialize(data)
    @name = data.name
    @url = data.external_urls["spotify"]
    @type = data.type
    @image = image_from_data(data)
  end
  
  def self.find(suggestion_array)
    suggestion_array.map do |suggestion|
      if suggestion["music_type"] == "artist"
        data = RSpotify::Artist.find(suggestion["music_id"])
      elsif suggestion["music_type"] == "album"
        data = RSpotify::Album.find(suggestion["music_id"])
      elsif suggestion["music_type"] == "track"
        data = RSpotify::Track.find(suggestion["music_id"])
      end

      new(data)
    end
  end

  private

  def image_from_data(data)
    if data.type == "track"
      return data.album.images.first["url"] unless data.album.images.empty?
    end

    data.images.first["url"] unless data.images.empty?
  end
end
