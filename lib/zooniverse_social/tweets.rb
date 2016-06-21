require 'twitter'

module ZooniverseSocial
  class Tweets
    attr_reader :data

    def initialize
      @twitter = Twitter::REST::Client.new({
        consumer_key: ENV.fetch('TWITTER_KEY'),
        consumer_secret: ENV.fetch('TWITTER_SECRET')
      })

      update
    end

    def update
      @data = @twitter.search('from:the_zooniverse', result_type: 'recent').take(3).collect &:to_h
    end
  end
end
