class Api::V1::SocialNetworksController < ApplicationController

    # GET /social-networks
    def index
      json_response({
        :twitter => [],
        :facebook => [],
        :instagram => []
      })
    end
end
