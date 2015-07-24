require 'spec_helper'
require 'json'

describe "TVDB::Series" do
  include_context "Series Subclass"

  describe "Initialization" do
    it "should throw an error when trying to instantiate TVDB::Series::Base directly" do
      expect { TVDB::Series::Base.new }.to raise_error( Exception )
    end
  end
  
end
