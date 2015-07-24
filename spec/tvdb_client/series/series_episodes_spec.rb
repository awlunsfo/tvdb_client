require 'spec_helper'
require 'json'

describe "TVDB::Series" do
  include_context "Authentication"

  before( :each ) do
    authenticate_connection
  end

  let( :series_id  ) { '76703' }

  let( :series_opts ) {
    {
      connection: connection,
      series_id:  series_id,
    }
  }

  subject { TVDB::Series::Episodes.new( series_opts ) }

  describe "Initialization" do
    it "should create an instance of TVDB::Series" do
      expect( subject ).to be_a_kind_of( TVDB::Series::Episodes )
    end

    it "should set a connection and a series ID" do
      expect( subject.connection ).to be_a_kind_of( TVDB::Connection )
      expect( subject.series_id  ).to eq( '76703' )
    end
  end

  describe "Episodes for a Series" do
    context 'Listing episodes' do
      it "should list the episodes for a series" do
        episodes = subject.list
        expect( episodes ).to be_a_kind_of( Hash )
        expect( episodes["data"] ).to be_a_kind_of( Array )
        expect( episodes["data"].length > 1 ).to be( true )
      end
    end

    context 'Querying' do
      it "should be able to query episodes for a series" do
        expect( subject ).to respond_to( :query )
      end

      it "should return results that match the query" do
        expect{ subject.query( params: { airedSeason: 15 } ) }.not_to raise_error
        query = subject.query( params: { airedSeason: 15 } )

        expect( query["data"][-1]["airedSeason"] ).to eq( "15" )
      end

      it "should return parameters to query by" do
        expect( subject.query_params["data"] ).to be_a_kind_of( Array )
        expect( subject.query_params["data"][0] ).to eq( "airedSeason" )
      end
    end

    context 'Summary' do
      it "should return a summary of episodes for the series" do
        expect( subject.summary["data"]["airedSeasons"].length ).to eq( 17 )
      end
    end
  end
  
end
