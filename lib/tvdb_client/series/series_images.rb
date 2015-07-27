module TVDB
  class Series
    class Images < TVDB::Series::Base

      def initialize( options )
        @connection = options.fetch( :connection )
        @series_id  = options.fetch( :series_id )
        @parameters = options.fetch( :params ) { {} }
        @route      = "/series/#{series_id}/images"
      end

    end
  end
end
