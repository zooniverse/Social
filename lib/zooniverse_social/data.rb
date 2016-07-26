require 'concurrent'

require 'zooniverse_social/posts'
require 'zooniverse_social/statuses'
require 'zooniverse_social/tweets'
require 'zooniverse_social/task_observer'

module ZooniverseSocial
  class Data
    def self.posts
      @posts ||= Posts.new
    end

    def self.tweets
      @tweets ||= Tweets.new
    end

    def self.statuses
      @statuses ||= Statuses.new
    end

    def self.sources
      [posts, tweets, statuses]
    end

    def self.current
      {
        posts: posts.data,
        tweets: tweets.data,
        statuses: statuses.data
      }
    end

    def self.update
      sources.each &:update
    end

    def self.start
      task = Concurrent::TimerTask.new(execution_interval: 600, timeout_interval: 20, run_now: true){ update }.execute
      TaskObserver.new task, method(:start)
    end
  end
end
