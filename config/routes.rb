Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index', as: :root
  
  get 'procedure-browser' => 'home#index', as: :home
  
  
  
  
  get 'procedure-browser/work-packages' => 'work_package#index', as: :work_package_list
  get 'procedure-browser/work-packages/:work_package' => 'work_package#show', as: :work_package_show
  
  get 'procedure-browser/work-packages/:work_package/business-items' => 'work_package_business_item#index', as: :work_package_business_item_list
  
  get 'procedure-browser/work-packages/:work_package/business-items/past' => 'work_package_past_business_item#index', as: :work_package_past_business_item_list
  
  get 'procedure-browser/work-packages/:work_package/business-items/future' => 'work_package_future_business_item#index', as: :work_package_future_business_item_list
  
  get 'procedure-browser/work-packages/:work_package/business-items/undated' => 'work_package_undated_business_item#index', as: :work_package_undated_business_item_list
  
  get 'procedure-browser/business-items' => 'business_item#index', as: :business_item_list
  get 'procedure-browser/business-items/:business_item' => 'business_item#show', as: :business_item_show
  
  get 'procedure-browser/business-items/:business_item/steps' => 'business_item_step#index', as: :business_item_step_list
  
  get 'procedure-browser/procedures' => 'procedure#index', as: :procedure_list
  get 'procedure-browser/procedures/:procedure' => 'procedure#show', as: :procedure_show
  
  get 'procedure-browser/procedures/:procedure/work-packages' => 'procedure_work_package#index', as: :procedure_work_package_list
  
  get 'procedure-browser/procedures/:procedure/calculation-styles' => 'procedure_calculation_style#index', as: :procedure_calculation_style_list
  
  get 'procedure-browser/procedures/:procedure/step-types' => 'procedure_step_type#index', as: :procedure_step_type_list
  get 'procedure-browser/procedures/:procedure/step-types/:step_type' => 'procedure_step_type#show', as: :procedure_step_type_show
  
  get 'procedure-browser/procedures/:procedure/step-types/:step_type/steps' => 'procedure_step_type_step#index', as: :procedure_step_type_step_list
  
  get 'procedure-browser/procedures/:procedure/steps' => 'procedure_step#index', as: :procedure_step_list
  get 'procedure-browser/procedures/:procedure/steps/:step' => 'procedure_step#show', as: :procedure_step_show
  
  get 'procedure-browser/procedures/:procedure/steps/:step/business-items' => 'procedure_step_business_item#index', as: :procedure_step_business_item_list
  
  get 'procedure-browser/procedures/:procedure/steps-with-depths' => 'procedure_step_with_depth#index', as: :procedure_step_with_depth_list
  
  get 'procedure-browser/procedures/:procedure/routes' => 'procedure_route#index', as: :procedure_route_list
  get 'procedure-browser/procedures/:procedure/routes/checker' => 'procedure_route#checker', as: :procedure_route_checker
  
  get 'procedure-browser/procedures/:procedure/clocks' => 'procedure_clock#index', as: :procedure_clock_list
  
  get 'procedure-browser/procedures/:procedure/step-collections' => 'procedure_step_collection#index', as: :procedure_step_collection_list
  
  get 'procedure-browser/calculation-styles' => 'calculation_style#index', as: :calculation_style_list
  get 'procedure-browser/calculation-styles/:calculation_style' => 'calculation_style#show', as: :calculation_style_show
  
  get 'procedure-browser/calculation-styles/:calculation_style/work-packages' => 'calculation_style_work_package#index', as: :calculation_style_work_package_list
  
  get 'procedure-browser/calculation-styles/:calculation_style/procedures' => 'calculation_style_procedure#index', as: :calculation_style_procedure_list
  
  get 'procedure-browser/step-types' => 'step_type#index', as: :step_type_list
  get 'procedure-browser/step-types/:step_type' => 'step_type#show', as: :step_type_show
  
  get 'procedure-browser/step-types/:step_type/steps' => 'step_type_step#index', as: :step_type_step_list
  
  get 'procedure-browser/steps' => 'step#index', as: :step_list
  get 'procedure-browser/steps/:step' => 'step#show', as: :step_show
  
  get 'procedure-browser/steps/:step/business-items' => 'step_business_item#index', as: :step_business_item_list
  
  get 'procedure-browser/steps/:step/routes' => 'step_route#index', as: :step_route_list
  
  get 'procedure-browser/steps/:step/clocks' => 'step_clock#index', as: :step_clock_list
  
  get 'procedure-browser/steps/:step/step-collections' => 'step_step_collection#index', as: :step_step_collection_list
  
  get 'procedure-browser/steps/:step/procedures' => 'step_procedure#index', as: :step_procedure_list
  
  get 'procedure-browser/steps/:step/procedures-with-step-depth' => 'step_procedure_with_step_depth#index', as: :step_procedure_with_step_depth_list
  
  get 'procedure-browser/step-collections' => 'step_collection#index', as: :step_collection_list
  get 'procedure-browser/step-collections/:step_collection' => 'step_collection#show', as: :step_collection_show
  
  get 'procedure-browser/step-collections/:step_collection/steps' => 'step_collection_step#index', as: :step_collection_step_list
  
  
  # Stubs
  
  get 'procedure-browser/routes' => 'route#index', as: :route_list
  get 'procedure-browser/routes/:route' => 'route#show', as: :route_show
  
  get 'procedure-browser/clocks' => 'clock#index', as: :clock_list
  get 'procedure-browser/clocks/:clock' => 'clock#show', as: :clock_show
  
  get 'procedure-browser/houses' => 'house#index', as: :house_list
  get 'procedure-browser/houses/:house' => 'house#show', as: :house_show
  
  get 'procedure-browser/legislatures' => 'legislature#index', as: :legislature_list
  get 'procedure-browser/legislatures/:legislature' => 'legislature#show', as: :legislature_show
  
  get 'procedure-browser/work-packageable-things' => 'work_packageable_thing#index', as: :work_packageable_thing_list
  get 'procedure-browser/work-packageable-things/:work_packageable_thing' => 'work_packageable_thing#show', as: :work_packageable_thing_show
end
