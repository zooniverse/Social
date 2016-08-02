module ZooniverseSocial
  require 'zooniverse_social/version'
  require 'zooniverse_social/server'
  require 'zooniverse_social/data'

  def self.start
    Data.start
  end
end
