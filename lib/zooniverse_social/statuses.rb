require 'zooniverse_social/updater'

module ZooniverseSocial
  class Statuses
    attr_reader :data

    def initialize
      @updater = Updater.new 'https://graph.facebook.com', '/v2.5/162907460488617/posts'
      update
    end

    def update
      response = @updater.update access_token: ENV.fetch('FACEBOOK_TOKEN'), limit: 3
      @data = response.fetch('data', []).collect do |status|
        post_id = status['id'].split('_').last

        {
          message: status['message'],
          created_at: status['created_time'],
          link: "https://www.facebook.com/therealzooniverse/posts/#{ post_id }"
        }
      end
    end
  end
end
