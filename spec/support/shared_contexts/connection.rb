require 'rspec'
require 'spec_helper'

shared_context "Connection" do
  let( :connection_options ) {
    {
      host_url: "https://api.thetvdb.localhost.com"
    }
  }

  let( :connection ) {
    TVDB::Connection.new( host_url: connection_options[:host_url] )
  }
end
