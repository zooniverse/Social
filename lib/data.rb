require 'concurrent'

require_relative 'posts'
require_relative 'statuses'
require_relative 'tweets'

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
    Concurrent::TimerTask.new(execution_interval: 600, run_now: true){ update }.execute
  end
end
