require 'test_helper'

describe "Food API" do
  before do
    @food = Food.business(["food_id" => "banana-republic-bellevue"]).first
  end

  it "knows its name", :vcr do
    assert_equal "Banana Republic", @food.name
  end

  it "knows its phone number", :vcr do
    assert_equal "+1-425-453-0991", @food.phone
  end

  it "knows its address", :vcr do
    assert_equal ["208 Bellevue Sq", "Bellevue, WA 98004"], @food.address
  end

  it "returns an Array when asked for an address", :vcr do
    assert_instance_of Array, @food.address
  end

  it "knows its image_url", :vcr do
    assert_equal "https://s3-media2.fl.yelpcdn.com/bphoto/347g68BmH7R424I3PraCIA/ms.jpg", @food.image_url
  end

  it "knows its rating", :vcr do
    assert_equal "https://s3-media1.fl.yelpcdn.com/assets/2/www/img/e8b5b79d37ed/ico/stars/v1/stars_large_3.png", @food.rating
  end

  it "knows its url", :vcr do
    assert_equal "http://www.yelp.com/biz/banana-republic-bellevue?utm_campaign=yelp_api&utm_medium=api_v2_business&utm_source=8JQ1Y278w82YImqqyGOs2A", @food.url
  end
end
