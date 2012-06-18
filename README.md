# rack-musicindex

A Rack middleware to publish directries containing media files as podcast

## Installation

Add this line to your application's Gemfile:

    gem 'rack-musicindex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-musicindex

## Usage

    require 'sinatra'
    require 'rack-musicindex'
    
    use Rack::MusicIndex, {
      '/foo' => '/path/to/mp3s'
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
