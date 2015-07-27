require 'spec_helper'
require 'json'

describe "TVDB::Series" do
  include_context "Series Subclass"

  let( :init_opts ) {
    series_opts[:params] = { :keys => "seriesName" }

    series_opts
  }

  subject { TVDB::Series::Filter.new( init_opts ) }

  describe "Initialization" do
    it "should create an instance of TVDB::Series" do
      expect( subject ).to be_a_kind_of( TVDB::Series::Filter )
    end

    it "should set a connection and a series ID" do
      expect( subject.connection ).to be_a_kind_of( TVDB::Connection )
      expect( subject.series_id  ).to eq( '76703' )
    end
  end

  describe "Filter for a Series" do
    it "should filter the keys returned from a /series GET" do
      expect( subject.list ).to be_a_kind_of( Hash )
      expect( subject.list["data"] ).to have_key( "seriesName" )
      expect( subject.list["data"].length ).to eq( 1 )
    end

    it "should return a list of keys to filter by" do
      response = subject.params["data"]["params"]

      expect( response ).to be_a_kind_of( Array )
      expect( response.length > 1 ).to be( true )
    end

    it "should not respond to query_params" do
      expect { subject.query_params }.to raise_error( NotImplementedError )
    end
  end
  
end
