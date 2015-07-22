require 'spec_helper'
require 'json'

describe "TVDB::Series" do

  include_context "Connection"

  subject { TVDB::Series.new( connection ) }

  describe "Initialization" do
    it "should create an instance of TVDB::Series" do
      expect( subject ).to be_a_kind_of( TVDB::Series )
    end

    it "should set a connection accessor" do
      expect( subject.connection ).to be_a_kind_of( TVDB::Connection )
    end
  end
  
end
