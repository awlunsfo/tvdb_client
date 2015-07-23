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

    private

    def get_series( series_id, options = {} )
      series = connection.get( route, options )
      @data  = series.body
    end

    # def set_attrs( series )
    #   series.body.each do |k,v|
    #     instance_variable_set("@#{k}", v) unless v.nil?
    #   end
    # end
  end
end
