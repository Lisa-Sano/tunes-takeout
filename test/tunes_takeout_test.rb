require 'test_helper'
require 'tunes_takeout'

describe TunesTakeoutWrapper do
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

  describe "favorite" do
    before do
      @favorite = TunesTakeoutWrapper.favorite('')
    end
  end
end