Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "entries#index"


  
  # Add investments page route
  get "investments/add_investment", to: "investments#add_investment", as: "add_investment"

  # Edit investments page route
  get "investments/:id/edit", to: "investments#edit", as: "edit_investment"

  # Update given investment
  patch "investments/:id", to: "investments#update", as: "update_investment"

  # Route for comparing investments
  get "investments/compare", to: "investments#compare", as: "compare_investments"

  # add investment route
  resources :investments, only: [ :create, :new, :index, :destroy, :show ]
end
