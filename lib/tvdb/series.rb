module TVDB
  class Series
    attr_accessor :connection
    attr_reader   :data, :route

    def initialize( connection, series_id )
      @connection = connection
      @route      = "/series/#{series_id}"

      get_series( series_id )
    end

    def episodes( options = {} )
      # TODO: Return an Episodes object instead of a hash.
      # Episodes object will be able to handle .query()
      connection.get( "#{route}/episodes", options ).body
    end

    def all_episodes
      first_page = connection.get( "#{route}/episodes" ).body["links"]["first"]
      last_page  = connection.get( "#{route}/episodes" ).body["links"]["last"]

      all_eps    = Array.new

      for page in first_page..last_page
        params   = { :params => { page: page } }
        all_eps << connection.get( "#{route}/episodes", params ).body["data"]
      end

      return all_eps.flatten
    end

    private

    def get_series( series_id, options = {} )
      series = connection.get( route, options )
      @data  = series.body
    end
  end
end
