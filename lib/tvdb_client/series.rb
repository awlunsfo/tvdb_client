module TVDB
  class Series
    attr_accessor :connection
    attr_reader   :data, :route, :series_id, :code

    def initialize( connection, series_id, options = {} )
      @connection = connection
      @series_id  = series_id
      @route      = "/series/#{series_id}"

      get_series( series_id, options )
    end

    def episodes( options = {} )
      params = {connection: connection, series_id: series_id, params: options }

      TVDB::Series::Episodes.new( params )
    end

    def all_episodes
      tr = TVDB::Service::Threading::ThreadedRequest.new( connection: connection )
      tr.make_request( "#{route}/episodes" )
    end

    private

    def get_series( series_id, options = {} )
      series = connection.get( route, options )
      @data  = series.body
      @code  = series.code
    end
  end
end
