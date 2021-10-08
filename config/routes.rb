Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      post "/login", to: "users#login"
      get "auto_login", to: "users#auto_login"

      resources :assessments, only: [:show, :create, :destroy]
      resources :players, only: [:index]
    end
  end
end
