# rack-musicindex [![Build Status](https://secure.travis-ci.org/youpy/rack-musicindex.png)](http://travis-ci.org/youpy/rack-musicindex)

A Rack middleware to publish directories containing media files as podcast

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
