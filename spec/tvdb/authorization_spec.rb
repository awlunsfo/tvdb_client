require 'spec_helper'
require 'json'

describe "TVDB::Authorization" do

  include_context "Connection"
  include_context "Credentials"

  let( :valid_init_options ) {
    valid_creds[:connection] = connection
    valid_creds
  }

  let( :invvalid_init_options ) {
    invalid_creds[:connection] = connection
    invalid_creds
  }

  subject { TVDB::Authorization.new( valid_init_options ) }

  describe "initialization" do
    it "should create a TVDB::Authorization object" do
      expect( subject ).to be_a_kind_of( TVDB::Authorization )
    end
    
    it "should have a connection accessor" do
      expect( subject ).to respond_to( :connection )
      
      subject.connection.token = "pudding"
      expect( subject.connection.token ).to eq( "pudding" )
    end
  end

  describe "Authentication" do
    context 'Logging in' do
      it "should be able to log in" do
        expect( subject ).to respond_to( :login )
      end

      it "should set a token on the connection object upon successful login" do
        subject.login

        expect( subject.connection.token ).to be_a_kind_of( String )
        expect( subject.connection.token.length > 1 ).to be( true )
      end

      it "should not set a token upon failed login" do
        failure = TVDB::Authorization.new( invvalid_init_options )
        failure.login

        expect( failure.connection.token.length > 1 ).to be( false )
        expect( failure.login.code ).to be( 401 )
      end
    end

    context 'Refreshing tokens' do
      it "should refresh a valid token" do
        subject.login
        old_token = subject.connection.token

        subject.refresh_token
        new_token = subject.connection.token

        expect( old_token ).not_to eq( new_token )
      end
    end
  end
  
end
