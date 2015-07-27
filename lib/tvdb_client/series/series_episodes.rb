module TVDB
  class Series
    class Episodes < TVDB::Series::Base

      def initialize( options )
        @connection = options.fetch( :connection )
        @series_id  = options.fetch( :series_id )
        @parameters = options.fetch( :params ) { {} }
        @route      = "/series/#{series_id}/episodes"
      end

      def summary
        connection.get( "#{route}/summary" ).body
      end

    end
  end
end
