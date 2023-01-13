Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"
  delete "/logout", to: "sessions#destroy"
  get "/recipes", to: "recipes#index"
  post "/recipes", to: "recipes#create"
end
