require 'spec_helper'
require 'json'

describe "TVDB::Service::Threading" do
  include_context "Authentication"

  let(:init_options) { 
    {
      connection: connection,
      pool_size: 10
    }
  }

  subject { TVDB::Service::Threading::ThreadedRequest.new( init_options ) }

  describe "Initialization" do
    it "should take arguments and set attrs" do
      expect( subject.connection ).to be_a_kind_of( TVDB::Connection )
      expect( subject.pool_size  ).to be_a_kind_of( Integer )
    end

    it "should default to a pool size of 10" do
      opts = { connection: connection }

      tr = TVDB::Service::Threading::ThreadedRequest.new( opts )
      expect( tr.pool_size ).to eq( 10 )
    end
  end

  describe "Requests" do
    before( :each ) do
      authenticate_connection
    end

    it "should be able to make a request" do
      expect( subject ).to respond_to( :make_request )
    end

    it "should return an array of results" do
      response = subject.make_request( "/series/99999/episodes" )

      expect( response ).to be_a_kind_of( Array )
      expect( response.length > 0 ).to be( true )
    end

    it "should bail if the route doesn't return a 200 response" do
      expect( subject.make_request( "/series/12345/episodes" ).code ).to eq( 404 )
    end

    it "should limit connections to the pool size" do
      skip "Not sure how to test this one yet"
    end
  end
end
