require 'sinatra/base'

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
    series_routes( request, params["id"], 'responses/series.json')
  end

  get '/series/:id/episodes' do
    page = params["page"]

    if params["id"] == "76703"
      if page == "1" || !page
        series_routes( request, params["id"], 'responses/series_episodes_page_1.json')
      elsif page == "2"
        series_routes( request, params["id"], 'responses/series_episodes_page_2.json')
      end
    elsif params["id"] == "99999"
      series_routes( request, params["id"], 'responses/series_episodes_page_n.json')
    else
      not_found_json_response( params["id"] )
    end
  end

  get '/series/:id/episodes/query' do
    aired_season = params["airedSeason"]

    json_response 200, 'responses/series_episodes_query_airedSeason.json'
  end

  get '/series/:id/episodes/query/params' do
    json_response 200, 'responses/series_episodes_query_params.json'
  end

  get '/series/:id/episodes/summary' do
    json_response 200, 'responses/series_episodes_summary.json'
  end

  private

  def series_routes( request, id, json_response_string )
    if bad_auth_header?( request )
      unauthed_json_response 
    elsif id == '76703' || id == "99999"
      json_response 200, json_response_string
    else
      not_found_json_response( id )
    end
  end

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

  def not_found_json_response( id )
    content_type :json
    status 404
    "{\"Error\": \"ID: #{id} not found\"}"
  end

  def bad_auth_header?( request )
    request.env["HTTP_AUTHORIZATION"] == "Bearer" ? true : false
  end
end
