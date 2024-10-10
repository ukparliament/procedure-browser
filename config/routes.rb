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
  
  get 'steps/:step/work-packageable-things' => 'step_work_packageable_thing#index', as: :step_work_packageable_thing_list
  
  get 'houses' => 'house#index', as: :house_list
  get 'house/:house' => 'house#show', as: :house_show
  
  get 'legislatures' => 'legislature#index', as: :legislature_list
  get 'legislatures/:legislature' => 'legislature#show', as: :legislature_show
  
  get 'procedures' => 'procedure#index', as: :procedure_list
  get 'procedures/:procedure' => 'procedure#show', as: :procedure_show
  
  get 'work-packages' => 'work_package#index', as: :work_package_list
  get 'work-packages/:work_package' => 'work_package#show', as: :work_package_show
  
  get 'work-packageable-things' => 'work_packageable_thing#index', as: :work_packageable_thing_list
  get 'work-packageable-things/:work_packageable_thing' => 'work_packageable_thing#show', as: :work_packageable_thing_show
end
