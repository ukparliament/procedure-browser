Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index', as: :home
  
  get 'step-types' => 'step_type#index', as: :step_type_list
  get 'step-types/:step_type' => 'step_type#show', as: :step_type_show
  
  get 'step-types/:step_type/steps' => 'step_type_step#index', as: :step_type_step_list
  
  get 'steps' => 'step#index', as: :step_list
  get 'steps/:step' => 'step#show', as: :step_show
  
  get 'houses' => 'house#index', as: :house_list
  get 'house/:house' => 'house#show', as: :house_show
  
  get 'legislatures' => 'legislature#index', as: :legislature_list
  get 'legislatures/:legislature' => 'legislature#show', as: :legislature_show
end
