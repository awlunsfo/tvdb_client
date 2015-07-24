module TVDB
  module Service
    module Threading
      class ThreadedRequest

        attr_reader   :connection, :pool_size
        attr_accessor :threads

        def initialize( options )
          @connection = options.fetch( :connection )
          @pool_size  = options.fetch( :pool_size )  { 10 }
          @threads    = Array.new
        end

        def make_request( route )
          response   = connection.get( route )

          return response if response.code != 200

          links      = connection.get( route ).body["links"]
          first_page = links["first"]
          last_page  = links["last"]
          @results   = Array.new

          for page in first_page..last_page
            manage_thread_pool

            threads << Thread.new( page ) do |page_num|
              params   = { :params => { page: page_num } }
              @results << connection.get( route, params ).body["data"]
            end
          end

          threads.each { |thread| thread.join }

          return @results.flatten
        end

        private

        def manage_thread_pool
          while threads.length > 10
            threads.each { |thread| threads.delete( thread ) if thread.stop? }
            sleep 0.01
          end
        end

      end
    end
  end
end
