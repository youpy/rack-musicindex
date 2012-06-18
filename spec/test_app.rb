require 'sinatra'
require 'rack-musicindex'

use Rack::MusicIndex, {
  '/foo' => File.expand_path(File.dirname(__FILE__) + '/fixtures/foo')
}
