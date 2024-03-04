Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "financial#index"
  resources :financial

  get "financial_months", to: "financial#new"
  get "current_month_history", to: "financial#current_month_history"
  get "history", to: "financial#history"
  post "financial_months", to: "financial#create"
  post "new_expense", to: "financial#new_expense"
end
