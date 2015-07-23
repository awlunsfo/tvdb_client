module TVDB
  class Client
    attr_accessor :connection
    attr_reader   :auth

    def initialize( options )
      authenticate( options )
    end

    def refresh_token
      auth.refresh_token
    end

    def series( series_id )
      TVDB::Series.new( connection, series_id )
    end

    private

    def authenticate( options )
      @connection          = TVDB::Connection.new( options )
      options[:connection] = connection
      @auth                = TVDB::Authorization.new( options )

      login = auth.login

      raise "#{login}" if login.code == 401
    end
  end
end
