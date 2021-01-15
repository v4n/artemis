Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
     resources :social_networks, :only => [:index], :path => '/social-networks'
    end
  end
end
