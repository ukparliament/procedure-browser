Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index', as: :home
  
  get 'work-packages' => 'work_package#index', as: :work_package_list
  get 'work-packages/:work_package' => 'work_package#show', as: :work_package_show
  
  get 'work-packages/:work_package/business-items' => 'work_package_business_item#index', as: :work_package_business_item_list
  
  get 'work-packages/:work_package/business-items/past' => 'work_package_past_business_item#index', as: :work_package_past_business_item_list
  
  get 'work-packages/:work_package/business-items/future' => 'work_package_future_business_item#index', as: :work_package_future_business_item_list
  
  get 'work-packages/:work_package/business-items/undated' => 'work_package_undated_business_item#index', as: :work_package_undated_business_item_list
  
  get 'business-items' => 'business_item#index', as: :business_item_list
  get 'business-items/:business_item' => 'business_item#show', as: :business_item_show
  
  get 'business-items/:business_item/steps' => 'business_item_step#index', as: :business_item_step_list
  
  get 'procedures' => 'procedure#index', as: :procedure_list
  get 'procedures/:procedure' => 'procedure#show', as: :procedure_show
  
  get 'procedures/:procedure/work-packages' => 'procedure_work_package#index', as: :procedure_work_package_list
  
  get 'procedures/:procedure/calculation-styles' => 'procedure_calculation_style#index', as: :procedure_calculation_style_list
  
  get 'procedures/:procedure/step-types' => 'procedure_step_type#index', as: :procedure_step_type_list
  get 'procedures/:procedure/step-types/:step_type' => 'procedure_step_type#show', as: :procedure_step_type_show
  
  get 'procedures/:procedure/step-types/:step_type/steps' => 'procedure_step_type_step#index', as: :procedure_step_type_step_list
  
  get 'procedures/:procedure/steps' => 'procedure_step#index', as: :procedure_step_list
  get 'procedures/:procedure/steps/:step' => 'procedure_step#show', as: :procedure_step_show
  
  get 'procedures/:procedure/steps/:step/business-items' => 'procedure_step_business_item#index', as: :procedure_step_business_item_list
  
  get 'procedures/:procedure/steps-with-depths' => 'procedure_step_with_depth#index', as: :procedure_step_with_depth_list
  
  get 'procedures/:procedure/routes' => 'procedure_route#index', as: :procedure_route_list
  
  get 'procedures/:procedure/clocks' => 'procedure_clock#index', as: :procedure_clock_list
  
  get 'procedures/:procedure/step-collections' => 'procedure_step_collection#index', as: :procedure_step_collection_list
  
  get 'calculation-styles' => 'calculation_style#index', as: :calculation_style_list
  get 'calculation-styles/:calculation_style' => 'calculation_style#show', as: :calculation_style_show
  
  get 'calculation-styles/:calculation_style/work-packages' => 'calculation_style_work_package#index', as: :calculation_style_work_package_index
  
  get 'calculation-styles/:calculation_style/procedures' => 'calculation_style_procedure#index', as: :calculation_style_procedure_index
  
  get 'step-types' => 'step_type#index', as: :step_type_list
  get 'step-types/:step_type' => 'step_type#show', as: :step_type_show
  
  get 'step-types/:step_type/steps' => 'step_type_step#index', as: :step_type_step_list
  
  get 'steps' => 'step#index', as: :step_list
  get 'steps/:step' => 'step#show', as: :step_show
  
  get 'steps/:step/business-items' => 'step_business_item#index', as: :step_business_item_list
  
  get 'steps/:step/routes' => 'step_route#index', as: :step_route_list
  
  get 'steps/:step/clocks' => 'step_clock#index', as: :step_clock_list
  
  get 'steps/:step/step-collections' => 'step_step_collection#index', as: :step_step_collection_list
  
  get 'steps/:step/procedures' => 'step_procedure#index', as: :step_procedure_list
  
  get 'steps/:step/procedures-with-step-depth' => 'step_procedure_with_step_depth#index', as: :step_procedure_with_step_depth_list
  
  get 'step-collections' => 'step_collection#index', as: :step_collection_list
  get 'step-collections/:step_collection' => 'step_collection#show', as: :step_collection_show
  
  get 'step-collections/:step_collection/steps' => 'step_collection_step#index', as: :step_collection_step_list
  
  
  
  
  
  # Stubs
  
  get 'routes' => 'route#index', as: :route_list
  get 'routes/:route' => 'route#show', as: :route_show
  
  get 'clocks' => 'clock#index', as: :clock_list
  get 'clocks/:clock' => 'clock#show', as: :clock_show
  
  get 'houses' => 'house#index', as: :house_list
  get 'houses/:house' => 'house#show', as: :house_show
  
  get 'legislatures' => 'legislature#index', as: :legislature_list
  get 'legislatures/:legislature' => 'legislature#show', as: :legislature_show
  
  get 'work-packageable-things' => 'work_packageable_thing#index', as: :work_packageable_thing_list
  get 'work-packageable-things/:work_packageable_thing' => 'work_packageable_thing#show', as: :work_packageable_thing_show
end
