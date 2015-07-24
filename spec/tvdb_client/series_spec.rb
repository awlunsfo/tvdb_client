require 'spec_helper'
require 'json'

describe "TVDB::Series" do
  include_context "Authentication"

  before( :each ) do
    authenticate_connection
  end

  let( :series_id ) { '76703' }

  subject { TVDB::Series.new( connection, series_id ) }

  describe "Initialization" do
    it "should create an instance of TVDB::Series" do
      expect( subject ).to be_a_kind_of( TVDB::Series )
    end

    it "should set a connection accessor" do
      expect( subject.connection ).to be_a_kind_of( TVDB::Connection )
    end

    it "should return series data" do
      expect( subject.data ).to be_a_kind_of( Hash )
      expect( subject.data["data"]["id"] ).to eq( 76703 )
    end

    it "should handle series that do not exist" do
      bad_series = TVDB::Series.new( connection, '773747' )
      expect( bad_series.data["Error"] ).to eq( "ID: 773747 not found" )
    end
  end

  describe "Series Episodes" do
    it "should return episodes in a series" do
      expect( subject.episodes.list["data"] ).to be_a_kind_of( Array )
      expect( subject.episodes.list["links"]["next"] ).to eq( 2 )
    end

    it "should return the 2nd page of results" do
      result = subject.episodes( params: { page: 2 } ).list
      expect( result["links"]["next"] ).to eq( nil )
    end

    it "should be able to return all episodes for a series" do
      page1 = subject.episodes( params: { page: 1 } ).list["data"]
      page2 = subject.episodes( params: { page: 2 } ).list["data"]

      combined_pages = [page1, page2].flatten

      expect( subject.all_episodes.length ).to eq( combined_pages.length )
    end
  end
  
end
