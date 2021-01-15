class Api::V1::SocialNetworksController < ApplicationController

    # GET /social-networks
    def index
      json_response({
        :twitter =>  SocialNetworkService.new(Constants::SocialNetworks::TWITTER).call,
        :facebook =>  SocialNetworkService.new(Constants::SocialNetworks::FACEBOOK).call,
        :instagram =>  SocialNetworkService.new(Constants::SocialNetworks::INSTAGRAM).call
      })
    end
end
