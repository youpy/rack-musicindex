require 'builder'
require 'id3lib'
require 'kconv'

module Rack
  class MusicIndex
    def initialize(app, options = {})
      @app = app

      init(options)
    end

    def init(options)
      @dirs = options
    end

    def call(env)
      path_info = env['PATH_INFO']

      # to compare with static_path which is utf-8 encoding
      path_info.force_encoding('UTF-8') if path_info.respond_to? :force_encoding

      update_files

      if dirs[path_info]
        serve_podcast(env)
      elsif static_paths.include?(unescape(path_info))
        serve_mp3(env)
      else
        status, headers, response = @app.call(env)
      end
    end

    private

    def serve_podcast(env)
      status, headers, response = @app.call(env)

      method = env['REQUEST_METHOD']
      body = podcast(env)

      headers['Content-Type'] = 'application/xml;charset=utf-8'
      headers["Content-Length"] = body.bytesize.to_s

      [200, headers, method == 'GET' ? [body] : []]
    end

    def serve_mp3(env)
      status, headers, response = @app.call(env)

      method = env['REQUEST_METHOD']
      path_info = unescape(env['PATH_INFO'])
      body = open(static_paths[path_info], 'rb').read

      headers["Content-Type"] = 'audio/mpeg'
      headers["Content-Length"] = body.bytesize.to_s

      [200, headers, method == 'GET' ? [body] : []]
    end

    def dirs
      @dirs
    end

    def files(path)
      @files[path]
    end

    def static_paths
      @static_paths
    end

    def update_files
      @files = {}
      @static_paths = {}

      dirs.each do |path, dir|
        @files[path] = Dir[dir + '/*.mp3']
        @files[path].each do |filename|
          @static_paths[path + '/' + ::File.basename(filename)] = filename
        end
      end
    end

    def id3(filename)
      value = {}
      tag = ID3Lib::Tag.new(filename)
      {
        :TIT2 => :name,
        :TPE1 => :artist,
      }.each do |id, key|
        frame = tag.frame(id)

        if frame
          if frame[:textenc] == 1
            v = Kconv.kconv(frame[:text] , Kconv::UTF8, Kconv::UTF16)
          else
            v = frame[:text]
          end
        end

        value[key] = v
      end

      value
    end

    def podcast(env)
      path  = env['PATH_INFO']
      req   = Rack::Request.new(env)
      url   = req.url
      files = files(path)
      xml   = ::Builder::XmlMarkup.new(:indent => 2)

      xml.instruct! :xml, :version => '1.0'
      xml.rss :version => "2.0", 'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd' do
        xml.channel do
          xml.title path
          xml.description 'Generated by Rack::MusicIndex'
          xml.link url

          files.each do |file|
            tag = id3(file)
            author = tag[:artist]
            name = ::File.basename(file)
            item_link = escape(url + '/' + name)

            xml.item do
              xml.title tag[:name] || name
              xml.description name
              xml.link item_link
              xml.guid item_link
              xml.enclosure :url => item_link

              if author
                xml.author author
                xml.itunes :author, author
              end
            end
          end
        end
      end
    end

    def escape(str)
      URI.escape(str)
    end

    def unescape(str)
      URI.unescape(str)
    end
  end
end
