Rails.application.routes.draw do
  devise_for :users

  post "login", to: "authentication#login"

  namespace :api do
    namespace :v1 do
      resources :books, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
end
