require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/spec'
require 'minispec-metadata'
require 'vcr'
require 'minitest-vcr'
require 'webmock/minitest'
require 'minitest/reporters'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
MinitestVcr::Spec.configure!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:spotify_known] = OmniAuth::AuthHash.new(
       { provider: "spotify", uid: "known_user", info: { "name" => "known user", "image" => "image" }
  })

  OmniAuth.config.mock_auth[:spotify_unknown] = OmniAuth::AuthHash.new(
       { provider: "spotify", uid: "lisa", info: { "name" => "lisa", "image" => "lisa_image" }
  })

  # OmniAuth.config.mock_auth[:spotify_uid] = OmniAuth::AuthHash.new(
  #      { provider: "spotify", uid: "preferred", info: { "id" => "not_lisa", "name" => "lisa", "image" => "not_lisa_image" }
  # })
end
