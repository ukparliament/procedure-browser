Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index', as: :home
  
  get 'step-types' => 'step_type#index', as: :step_type_list
  get 'step-types/:step_type' => 'step_type#show', as: :step_type_show
  
  get 'steps' => 'step#index', as: :step_list
  get 'steps/:step' => 'step#show', as: :step_show
end
