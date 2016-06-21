require 'rspec/its'
require 'webmock/rspec'
require 'rack/test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

require 'zooniverse_social'

ENV['RACK_ENV'] = 'test'
ENV['FACEBOOK_TOKEN'] = 'facebook_token'
ENV['TWITTER_KEY'] = 'twitter_key'
ENV['TWITTER_SECRET'] = 'twitter_secret'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include ApiHelper, type: :server

  config.before(:suite){ WebMock.disable_net_connect! }
  config.after(:suite){ WebMock.allow_net_connect! }

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!
  config.warnings = true

  config.order = :random
  Kernel.srand config.seed
end
