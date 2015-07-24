require 'rspec'
require 'spec_helper'

shared_context "Series Subclass" do
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
end
