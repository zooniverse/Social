require 'sinatra'
require 'json'
require 'zooniverse_social/data'

module ZooniverseSocial
  class Server < Sinatra::Base
    before do
      content_type :json
    end

    after do
      response.body = response.body.to_json
    end

    get '/' do
      Data.current
    end
  end
end
