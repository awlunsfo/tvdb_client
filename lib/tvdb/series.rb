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
      links      = connection.get( "#{route}/episodes" ).body["links"]
      first_page = links["first"]
      last_page  = links["last"]
      threads    = Array.new
      @all_eps   = Array.new

      for page in first_page..last_page
        threads << Thread.new( page ) do |page_num|
          params   = { :params => { page: page_num } }
          @all_eps << connection.get( "#{route}/episodes", params ).body["data"]
        end
      end

      threads.each { |thread| thread.join }

      return @all_eps.flatten
    end

    private

    def get_series( series_id, options = {} )
      series = connection.get( route, options )
      @data  = series.body
    end
  end
end
