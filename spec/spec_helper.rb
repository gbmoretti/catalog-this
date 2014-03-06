ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'

require_relative '../catalog_this'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  described_class
end



