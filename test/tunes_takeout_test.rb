require 'test_helper'
require 'tunes_takeout'

describe TunesTakeoutWrapper do
  UUID = "1bb6ba17-f330-4546-b641-6772af537587"

  describe "search" do
    before do
      @search = TunesTakeoutWrapper.search("banana")
    end

    it "returns a Hash", :vcr do
      assert_instance_of Hash, @search
    end

    it "returns a Hash with 2 keys", :vcr do
      assert_equal 2, @search.length
    end

    it "returns a Hash with an href key", :vcr do
      refute_nil @search["href"]
    end

    it "returns a Hash with a suggestions key", :vcr do
      refute_nil @search["suggestions"]
    end

    it "returns 10 suggestions by default", :vcr do
      assert_equal 10, @search["suggestions"].length
    end

    it "returns an id for each suggestion", :vcr do
      refute_nil @search["suggestions"][0]["id"]
    end

    it "returns a food_id for each suggestion", :vcr do
      refute_nil @search["suggestions"][0]["food_id"]
    end

    it "returns a music_id for each suggestion", :vcr do
      refute_nil @search["suggestions"][0]["music_id"]
    end

    it "returns a music_type for each suggestion", :vcr do
      refute_nil @search["suggestions"][0]["music_type"]
    end
  end

  describe "top_suggestions" do
    before do
      @top = TunesTakeoutWrapper.top_suggestions
    end

    it "returns 20 suggestions by default", :vcr do
      assert_equal 20, @top["suggestions"].length
    end
  end

  describe "retrieve" do
    before do
      @retrieved = TunesTakeoutWrapper.retrieve("Vz0KNY-RRwADbn2k")
    end

    it "returns nil if no suggestion with that id exists", :vcr do
      assert_nil TunesTakeoutWrapper.retrieve(12345)
    end

    it "returns a Hash", :vcr do
      assert_instance_of Hash, @retrieved
    end

    it "returns a Hash with 2 keys", :vcr do
      assert_equal 2, @retrieved.length
    end

    it "returns a Hash with an href key", :vcr do
      refute_nil @retrieved["href"]
    end

    it "returns a Hash with a suggestion key", :vcr do
      refute_nil @retrieved["suggestion"]
    end

    it "returns a suggestion in a Hash", :vcr do
      assert_instance_of Hash, @retrieved["suggestion"]
    end
  end

  describe "favorite with real suggestion id" do

    before do
      @favorite = TunesTakeoutWrapper.favorite(UUID, "Vz0KNY-RRwADbn2k")
    end

    after do
      TunesTakeoutWrapper.unfavorite(UUID, "Vz0KNY-RRwADbn2k")
    end

    it "should return status code 201 if successful", :vcr do
      assert_equal 201, @favorite
    end

    it "should return a status code 409 if the user already favorited that suggestion", :vcr do
      favorite_again = TunesTakeoutWrapper.favorite(UUID, "Vz0KNY-RRwADbn2k")
      assert_equal 409, favorite_again
    end

    describe "get_favorites" do
      before do
        @get_favorites = TunesTakeoutWrapper.get_favorites(UUID)
      end

      it "should return a Hash", :vcr do
        assert_instance_of Hash, @get_favorites
      end

      it "should contain the favorited suggestion Vz0KNY-RRwADbn2k", :vcr do
        assert_equal true, @get_favorites["suggestions"].include?("Vz0KNY-RRwADbn2k")
      end
    end
  end

  describe "favorite with non-existent suggestion id" do

    it "should return a status code 404 if no suggestion with the id exists", :vcr do
      status = TunesTakeoutWrapper.favorite(UUID, 12345)
      assert_equal 404, status
    end
  end

  describe "unfavorite" do
    before do
      TunesTakeoutWrapper.favorite(UUID, "Vz0KNY-RRwADbn2k")
      @unfavorite = TunesTakeoutWrapper.unfavorite(UUID, "Vz0KNY-RRwADbn2k")
    end

    it "should remove a previously favorited suggestion from the user's favorite list", :vcr do
      assert_equal false, TunesTakeoutWrapper.get_favorites(UUID).include?("Vz0KNY-RRwADbn2k")
    end

    it "should return a status code 204 if successful", :vcr do
      assert_equal 204, @unfavorite
    end

    it "should return a status code 404 if the suggestion id is fake", :vcr do
      assert_equal 404, TunesTakeoutWrapper.unfavorite(UUID, 12345)
    end
  end
end