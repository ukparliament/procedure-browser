class WorkPackageFutureBusinessItemController < ApplicationController

  # We include modules required to get a work package.
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageFutureBusinessItems
  include Sparql::Queries::WorkPackageFutureBusinessItems
  include Sparql::Get::Response
  include Timeline::Timeline

  def index
    work_package_id = params[:work_package]
  
    # We get the work package.
    @work_package = get_work_package( work_package_id )
  
    # We get all the future business items for the work package.
    @work_package_business_items = get_work_package_future_business_items( work_package_id )
  
    # We construct an array of future business items structured for display as nested lists.
    # These are an array of dates, containing an array of events, containing an array of steps.
    @work_package_future_business_items = construct_business_items_array_for_work_package( @work_package_business_items )
    
    # We know the array of business items is actually an array of actualisations, some business items actualising more than one step.
    # We get the business item count.
    @business_item_count = get_business_item_count( @work_package_business_items )
  
    @page_title = "Future business items forming a work package for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package future business items</span>".html_safe
    @description = "Future business items forming a work package for #{@work_package.work_packageable_thing_label}."
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @work_package.work_packageable_thing_label, url: work_package_show_url }
    @crumb << { label: 'Business items', url: work_package_business_item_list_url }
    @crumb << { label: 'Future', url: nil }
    @section = 'work-packages'
  end
end
