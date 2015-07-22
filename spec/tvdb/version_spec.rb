require 'spec_helper'
require 'json'

describe "TVDB::Version" do

  describe "version" do
    it "should return the version of the API client" do
      expect( TVDB::VERSION ).to be_a_kind_of( String )
    end
  end

end
