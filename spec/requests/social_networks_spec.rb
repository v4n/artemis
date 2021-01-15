require 'rails_helper'

RSpec.describe 'Social Networks API V1', type: :request do

  describe 'GET /api/v1/social-networks' do
    before { get '/api/v1/social-networks' }

    it 'returns data from social networks' do
      expect(json).not_to be_empty
      social_networks_count = 3
      expect(json.size).to eq(social_networks_count)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end