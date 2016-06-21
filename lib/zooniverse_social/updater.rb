require 'faraday'

module ZooniverseSocial
  class Updater
    def initialize(host, path)
      @connection = Faraday.new host
      @path = path
    end

    def update(*args)
      response = @connection.get(@path, *args) do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
      end
      JSON.parse response.body
    end
  end
end
