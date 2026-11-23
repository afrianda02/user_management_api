Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  devise_for :users, skip: [:sessions, :registrations], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"
      post "auth/login", to: "auth#login"
      post "auth/refresh", to: "auth#refresh"
      delete "auth/logout", to: "auth#logout"
      get "auth/me", to: "auth#me"

      resources :users, only: [:index, :show, :update, :destroy]
      resources :job_categories
      # TODO: add nested routes if needed
    end
  end

  get "/auth/:provider/callback", to: "api/v1/oauth_callbacks#create"
  get "/auth/failure", to: "api/v1/oauth_callbacks#failure"
end