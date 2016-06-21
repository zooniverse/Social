module ApiHelper
  include Rack::Test::Methods

  def app
    ZooniverseSocial::Server
  end

  def json_response
    @_json ||= JSON.parse last_response.body
  end
end
