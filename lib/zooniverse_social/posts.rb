require 'zooniverse_social/updater'

module ZooniverseSocial
  class Posts
    attr_reader :data

    def initialize
      @blog_updater = Updater.new 'https://public-api.wordpress.com', '/rest/v1.1/sites/36711287/posts'
      @daily_updater = Updater.new 'https://public-api.wordpress.com', '/rest/v1.1/sites/57182749/posts'
      update
    end

    def update
      blog_data = _update @blog_updater
      daily_data = _update @daily_updater
      @data = (blog_data + daily_data).sort{ |a, b| b[:created_at] <=> a[:created_at] }.take 3
    end

    def _update(updater)
      response = updater.update number: 3, fields: 'ID,URL,title,date'
      response.fetch('posts', []).collect do |post|
        {
          id: post['ID'],
          title: post['title'],
          created_at: post['date'],
          link: post['URL']
        }
      end
    end
  end
end
