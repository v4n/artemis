require 'sinatra/base'

class FakeSocialNetworkEndpoint < Sinatra::Base
  get '/twitter' do
    plain_text_response
  end

  get '/facebook' do
    json_response 200, 'social_networks/facebook.json'
  end

  get '/instagram' do
    not_found_response
  end  

  private

  def plain_text_response
    content_type :text
    status 500

    'Greetings, Professor Falken.' 
  end

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end

  def not_found_response
    content_type :text
    status 404
  end
end