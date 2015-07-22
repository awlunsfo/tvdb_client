require 'rspec'
require 'spec_helper'

shared_context "Credentials" do
  let( :valid_creds ) {
    {
      :username   => "validuser",
      :userpass   => "validpass",
      :apikey     => "validapikey"
    }
  }

  let( :invalid_creds ) {
    {
      :username   => "invaliduser",
      :userpass   => "invalidpass",
      :apikey     => "invalidapikey"
    }
  }
end
