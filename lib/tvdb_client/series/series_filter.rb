module TVDB
  class Series
    class Filter < TVDB::Series::Base

      def initialize( options )
        @connection = options.fetch( :connection )
        @series_id  = options.fetch( :series_id )
        @parameters = options.fetch( :params ) { {} }
        @route      = "/series/#{series_id}/filter"
      end

      def params
        connection.get( "#{route}/params" ).body
      end

      def query_params
        raise NotImplementedError, "'.query_params' not implemented for #{self.class}. Please use '.params'"
      end
    end
  end
end
