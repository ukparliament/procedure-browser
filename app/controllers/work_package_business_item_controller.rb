class WorkPackageBusinessItemController < ApplicationController

  # We include modules required to get a work package.
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageBusinessItems
  include Sparql::Queries::WorkPackageBusinessItems
  include Sparql::Get::Response
  include Timeline::Timeline

  def index
    work_package_id = params[:work_package]
  
    # We get the work package.
    @work_package = get_work_package( work_package_id )
  
    # We get all the business items for the work package.
    @work_package_business_items = get_work_package_business_items( work_package_id )
  
    # We get arrays of pertinent past business items, future business items and undated business items.
    @work_package_pertinent_past_business_items = get_pertinent_business_items_of_type( @work_package_business_items, 'past' )
    @work_package_pertinent_future_business_items = get_pertinent_business_items_of_type( @work_package_business_items, 'future' )
    @work_package_pertinent_undated_business_items = get_pertinent_business_items_of_type( @work_package_business_items, 'undated' )
    
    # We construct arrays of past business items, future business items and undated business items structured for display as nested lists.
    # These are an array of dates, containing an array of business items, containing an array of steps.
    @work_package_past_business_items = construct_business_items_array_for_work_package( @work_package_pertinent_past_business_items )
    @work_package_future_business_items = construct_business_items_array_for_work_package( @work_package_pertinent_future_business_items )
    @work_package_undated_business_items = construct_business_items_array_for_work_package( @work_package_pertinent_undated_business_items )
    
    # We know the array of business items is actually an array of actualisations, some business items actualising more than one step.
    # We get the business item count.
    @business_item_count = get_business_item_count( @work_package_business_items )
    
    # We create an array of dated business items - past and future - in order to generate the RSS.
    @work_package_dated_business_items = @work_package_past_business_items + @work_package_future_business_items
    @work_package_dated_business_items.reverse!
  
    @page_title = "Business items forming the work package for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package business items</span>".html_safe
    @description = "Business items forming the work package for #{@work_package.work_packageable_thing_label}."
    @rss_url = work_package_business_item_list_url( :format => 'rss' )
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @work_package.work_packageable_thing_label, url: work_package_show_url }
    @crumb << { label: 'Business items', url: nil }
    @section = 'work-packages'
  end
end
