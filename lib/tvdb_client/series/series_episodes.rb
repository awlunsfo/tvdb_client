module TVDB
  class Series
    class Episodes

      attr_reader   :series_id, :data, :route
      attr_accessor :connection, :params

      def initialize( options )
        @connection = options.fetch( :connection )
        @series_id  = options.fetch( :series_id )
        @params     = options.fetch( :params ) { {} }
        @route      = "/series/#{series_id}/episodes"
      end

      def list
        connection.get( route, params ).body
      end

      def query( options )
        connection.get( "#{route}/query", options ).body
      end

      def query_params
        connection.get( "#{route}/query/params" ).body
      end

      def summary
        connection.get( "#{route}/summary" ).body
      end

    end
  end
end
