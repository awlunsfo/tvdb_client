module TVDB

  class Authorization

    attr_reader   :username, :password, :api_key
    attr_accessor :connection

    def initialize( options )
      @username    = options.fetch( :username ) 
      @password    = options.fetch( :userpass ) 
      @api_key     = options.fetch( :apikey )
      @connection  = options.fetch( :connection )
    end

    def login
      credentials = {
        :username => username, 
        :userpass => password,
        :apikey   => api_key
      }

      response = connection.post( "/login", body: credentials )

      handle_response( response )
    end

    def refresh_token
      response = connection.get( '/refresh_token' )

      handle_response( response )
    end

    private

    def handle_response( response )
      if response.code != 200
        connection.token = ""
      else
        connection.token = response.body["token"]
      end

      return response
    end

  end
end
