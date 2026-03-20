Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :products, only: [ :index, :create, :show, :update, :destroy ]

  resources :orders, only: [ :index, :show, :create ]

  get "up" => "rails/health#show", as: :rails_health_check
end
