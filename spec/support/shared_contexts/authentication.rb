require 'rspec'
require 'spec_helper'

shared_context "Authentication" do
  include_context "Credentials"
  include_context "Connection"
  
  def authenticate_connection
    valid_creds[:connection] = connection

    TVDB::Authorization.new( valid_creds ).login
  end
end
