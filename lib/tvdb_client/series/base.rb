module TVDB
  class Series
    class Base

      attr_reader   :series_id, :data, :route
      attr_accessor :connection, :parameters

      def initialize
        abstract_method
      end

      def list
        connection.get( route, parameters ).body
      end

      def query( options )
        connection.get( "#{route}/query", options ).body
      end

      def query_params
        connection.get( "#{route}/query/params" ).body
      end

      private

      def abstract_method
        raise Exception, "#{self.class}: This method needs to be implemented in the concrete class"
      end

    end
  end
end
