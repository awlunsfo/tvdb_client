require 'sinatra/base'
require 'multi_json'

class FakeTVDB < Sinatra::Base
  post '/login' do
    if JSON.parse( request.body.read )["username"] == "validuser"
      json_response 200, 'responses/login.json'
    else
      unauthed_json_response
    end
  end

  get '/refresh_token' do
    if bad_auth_header?( request )
      status 401
    else
      json_response 200, 'responses/refresh_token.json'
    end
  end

  get '/series/:id' do
    unauthed_json_response if bad_auth_header?( request )
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end

  def unauthed_json_response
    content_type :json
    status 401
    '{"Error":"API Key Required"}'
  end

  def bad_auth_header?( request )
    request.env["HTTP_AUTHORIZATION"] == "Bearer" ? true : false
  end
end
