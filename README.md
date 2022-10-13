# Zooniverse Social

Social media aggregation service for the Zooniverse

[![Build Status](https://travis-ci.org/zooniverse/Social.svg?branch=master)](https://travis-ci.org/zooniverse/Social)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zooniverse_social'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zooniverse_social

## Usage

### Boot the application
Run the app via the rackup cmd, <https://github.com/sinatra/sinatra#serving-a-modular-application>

`bundle exec rackup -p 4567`

### Install dependencies
`bundle install`

### Test the app
`bundle exec rspec`

### Publishing to [RubyGems](https://rubygems.org/)
`rake build` - to create the new gem version locally
`rake release` - to tag the gem and release it to RubyGems

## License

Copyright 2022 by the Zooniverse

The gem is available as open source under the terms of the [Apache License v2](https://opensource.org/licenses/Apache-2.0).
