require 'spec_helper'
require 'json'

describe "TVDB::Client" do

  include_context "Credentials"
  
  subject { TVDB::Client.new( valid_creds ) }

  describe "Initialization" do
    it "should require user credentials" do
      expect { TVDB::Client.new( invalid_creds ) }.to raise_error
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

end
