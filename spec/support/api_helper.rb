module ApiHelper
  include Rack::Test::Methods
  def app
    Server
  end

  def json_response
    @_json ||= JSON.parse last_response.body
  end
end
