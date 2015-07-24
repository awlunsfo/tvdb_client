module TVDB
  class Connection
    require "faraday"
    require "json"

    attr_accessor :token, :response_struct
    attr_reader   :connection, :host_url, :language, :version, :modified_since

    def initialize( options = {} )
      @token           = ""
      
      @host_url        = options.fetch( :host_url ) { Settings.tvdb.host_url }
      @language        = options[:language]
      @version         = options[:version]
      @modified_since  = options[:modified_since]

      @connection      = Faraday.new( :url => host_url, :ssl => { :verify => false } )
      @response_struct = Struct.new( :request_url, :code, :body, :headers )
    end

    def post( route, options )
      request_body = options.fetch( :body )

      response = connection.post do |req|
        req.url( route )
        req.headers = set_default_headers( options )
        req.body    = request_body.to_json
      end

      return parsed_response( response )
    end

    def get( route, options = {} )
      response = connection.get do |req|
        req.url( route )
        req.headers = set_default_headers( options )
        req.params  = options[:params] if options[:params]
      end

      return parsed_response( response )
    end

    def set_default_headers( options )
      headers = options[:headers] if options
      headers ||= {}

      headers["Authorization"]     ||= "Bearer #{token}"
      headers["Content-Type"]      ||= "application/json"
      headers["Accept-Language"]   ||= "#{language}"
      headers["Accept"]            ||= "application/vnd.thetvdb.v#{version}"
      headers["If-Modified-Since"] ||= "#{modified_since}"

      return headers
    end

    def parsed_response( response )
      unless response.body.empty?
        body = JSON.parse( response.body )
      else
        body = nil
      end

      response_struct.new(
        "#{host_url}#{response.env.url.request_uri}",
        response.status,
        body,
        response.env.response_headers
      )
    end
  end
end
