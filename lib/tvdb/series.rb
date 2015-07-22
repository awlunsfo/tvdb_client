module TVDB
  class Series
    attr_accessor :connection

    def initialize( connection )
      @connection = connection
    end

  end
end
