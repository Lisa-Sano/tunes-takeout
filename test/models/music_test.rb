require 'test_helper'

describe "Music" do

  describe "find class method" do
    before do
      @music = Music.find([{"music_id" => "0vD0IZ6ol5V30tWQRQKEb5", 
      "music_type" => "album"}])
      @first_music = @music.first
    end

    it "returns a collection of objects in an Array", :vcr do
      assert_instance_of Array, @music
    end

    it "returns a collection of Music instances", :vcr do
      assert_instance_of Music, @first_music
    end
  end

  describe "album type" do
    before do
      @album = Music.find([{"music_id" => "0vD0IZ6ol5V30tWQRQKEb5", 
      "music_type" => "album"}]).first
    end

    it "knows its name", :vcr do
      assert_equal "Apples & Bananas: A Wiggly Collection of Nursery Rhymes", @album.name
    end

    it "knows its image url", :vcr do
      assert_equal "https://i.scdn.co/image/597f7357238daf80808458073f80cf66444ca665", @album.image
    end

    it "knows its type", :vcr do
      assert_equal "album", @album.type
    end

    it "knows its uri", :vcr do
      assert_equal "spotify:album:0vD0IZ6ol5V30tWQRQKEb5", @album.uri
    end

    it "knows its url", :vcr do
      assert_equal "https://open.spotify.com/album/0vD0IZ6ol5V30tWQRQKEb5", @album.url
    end
  end

  describe "track type" do
    before do
      @track = Music.find([{
        "food_id"=>"ohana-seattle-2",
        "music_id"=>"0F3koXtzIYxsR8m2bEe5cE",
        "music_type"=>"track"}]).first
    end

    it "knows its type", :vcr do
      assert_equal "track", @track.type
    end

    it "knows its image (different location than other types)", :vcr do
      assert_equal "https://i.scdn.co/image/795fca98010efcdc79c0d293ed375e522a2ee22e", @track.image
    end
  end

  describe "artist type" do
    before do
      @artist = Music.find([{
        "food_id"=>"canlis-seattle",
        "music_id"=>"1zGRC20sEygsipCvPlsrZL",
        "music_type"=>"artist"}]).first
    end

    it "knows its type", :vcr do
      assert_equal "artist", @artist.type
    end
  end
end
