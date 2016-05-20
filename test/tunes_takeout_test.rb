require 'test_helper'
require 'tunes_takeout'

describe TunesTakeoutWrapper do
  describe "search" do
    before do
      @search = TunesTakeoutWrapper.search("banana")
    end

    it "returns a hash", :vcr do
      assert_instance_of Hash, @search
    end

    it "returns 10 suggestions by default", :vcr do
      assert_equal 10, @search["suggestions"].length
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
end