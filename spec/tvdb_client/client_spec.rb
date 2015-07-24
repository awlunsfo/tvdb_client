require 'spec_helper'
require 'json'

describe "TVDB::Client" do

  include_context "Credentials"
  
  subject { TVDB::Client.new( valid_creds ) }

  describe "Initialization" do
    it "should require user credentials" do
      expect { TVDB::Client.new( invalid_creds ) }.to raise_error( RuntimeError )
    end

    it "should authenticate the user and set a token" do
      expect( subject.connection.token ).to be_a_kind_of( String )
    end

    it "should set an auth accessor" do
      expect( subject.auth ).to be_a_kind_of( TVDB::Authorization )
    end
  end

  describe "Authentication" do
    it "should refresh the user's token" do
      old_token = subject.connection.token
      subject.refresh_token

      expect( subject.connection.token ).not_to eq( old_token )
    end
  end

  describe "Functionality" do
    context 'Series' do
      it "should return a series object" do
        pokemon = subject.series( '76703')

        expect( pokemon ).to be_a_kind_of( TVDB::Series )
        expect( pokemon.data ).to be_a_kind_of( Hash )
        expect( pokemon.data ).to have_key( "data" )
      end
    end
  end

end
