Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      post "/login", to: "users#login"
      get "auto_login", to: "users#auto_login"

      resources :teams, only: [:show]
      resources :notes, only: [:create, :update, :destroy]
      resources :assessments, only: [:show, :create, :destroy]
      resources :players, only: [:index, :show] do
        resources :assessments, only: [:index]
      end
    end
  end
end
