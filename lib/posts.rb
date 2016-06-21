require_relative 'updater'

class Posts
  attr_reader :data

  def initialize
    @updater = Updater.new 'https://public-api.wordpress.com', '/rest/v1.1/sites/36711287/posts'
    update
  end

  def update
    response = @updater.update number: 3, fields: 'ID,URL,title,date'
    @data = response.fetch('posts', []).collect do |post|
      {
        id: post['ID'],
        title: post['title'],
        created_at: post['date'],
        link: post['URL']
      }
    end
  end
end
