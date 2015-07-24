require 'spec_helper'
require 'json'

describe "TVDB::Connection" do

  include_context "Connection"

  subject { TVDB::Connection.new( connection_options ) }

  describe "Initialization" do

    it "should createa a connection and set attrs" do
      expect( subject.connection ).to be_a_kind_of( Faraday::Connection )
      expect( subject.host_url   ).to eq( connection_options[:host_url] )
      expect( subject.token      ).to eq( "" )
    end

    it "should setup a Response struct" do
      expect( subject.response_struct ).to be_a_kind_of( Class )
    end
 
  end

  describe "Ancillary operations" do

    context 'headers' do
      it "should set default headers for requests" do
        expect( subject.set_default_headers( {} ) ).to be_a_kind_of( Hash )
        expect( subject.set_default_headers( {} )["Content-Type"] ).to eq( "application/json" )
        expect( subject.set_default_headers( {} )["Authorization"] ).to eq( "Bearer " )
      end

      it "should override default headers " do
        custom_header = { :headers => { "Content-Type" => "text/html" } }

        expect( subject.set_default_headers( custom_header )["Content-Type"] ).to eq( "text/html" )
      end

      it "should apply custom headers" do
        custom_header = { :headers => { "howdy" => "g'day mate" } }

        expect( subject.set_default_headers( custom_header )["howdy"] ).to eq( "g'day mate" )
      end     
    end

    context 'responses' do
      let( :route    ) { "/login" }
      let( :response ) { subject.post( route, body: {} ) }

      it "should store responses in a struct" do
        expect( response ).to be_a_kind_of( Struct )
      end

      it "should set a code accessor" do
        expect( response ).to respond_to( :code )
        expect( response.code ).to eq( 401 )
      end

      it "should set a body accessor" do
        expect( response ).to respond_to( :body )
        expect( response.body ).to eq( {"Error"=>"API Key Required"} )
      end

      it "should set a headers accessor" do
        expect( response ).to respond_to( :headers )
        expect( response.headers ).to be_a_kind_of( Hash )
      end

      it "should set a request_url accessor" do
        expect( response ).to respond_to( :request_url )
        expect( response.request_url ).to eq( "#{connection_options[:host_url]}#{route}")
      end
    end
  end

  describe "REST operations" do
    include_context "Credentials"

    describe 'POSTing' do

      let( :post_params ) {
        {
          :body => { :bacon => "tasty" }
        }
      }

      it "should be able to POST json to a route" do
        expect( subject ).to respond_to( :post )
      end

      context 'Authorized requests' do
        let( :successful_post ) {
          subject.post( '/login', body: valid_creds )
        }

        it "should return a 200 upon successful POST" do
          expect( successful_post.code ).to be( 200 )
        end

        it "should return response headers" do
          expect( successful_post.headers["content-type"] ).to eq( "application/json" )
        end
      end

      context 'Unauthorized requests' do
        it "should return a 401 if unathorized" do
          expect( subject.post( '/login', post_params ).code ).to be( 401 )
        end
      end

    end

    describe "GETing" do
      it "should be able to GET a route" do
        expect( subject ).to respond_to( :get )
      end

      it "should take optional parameters" do
        param_req = subject.get( '/series/1234', params: { :page => 1 } )
        expect( param_req.request_url ).to match( 'page=1' )
      end

      context 'Unauthorized requests' do
        it "should return a 401 if unathorized" do
          expect( subject.get( '/series/1234' ).code ).to be( 401 )
        end
      end
    end
    
  end

end
