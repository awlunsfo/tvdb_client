require 'spec_helper'
require 'json'

describe "TVDB::Series" do
  include_context "Series Subclass"

  subject { TVDB::Series::Images.new( series_opts ) }

  describe "Initialization" do
    it "should create an instance of TVDB::Series" do
      expect( subject ).to be_a_kind_of( TVDB::Series::Images )
    end

    it "should set a connection and a series ID" do
      expect( subject.connection ).to be_a_kind_of( TVDB::Connection )
      expect( subject.series_id  ).to eq( '76703' )
    end
  end

  describe "Images for a Series" do
    it "should return a summary of images for the given series" do
      images = subject.list

      expect( images ).to be_a_kind_of( Hash )
      ["fanart", "poster", "season", "seasonwide", "series"].each do |type|
        expect( images["data"] ).to have_key( type )
      end
    end

    it "should return a user query" do
      results = subject.query( :keyType => "fanart" )

      expect( results["data"][0]["keyType"] ).to eq( "fanart" )
    end

    it "should list the parameters available to query by" do
      results = subject.query_params

      expect( results["data"].length > 1 ).to be( true )
    end
  end
  
end
