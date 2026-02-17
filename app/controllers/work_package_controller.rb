class WorkPackageController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::WorkPackageCount
  include Sparql::Queries::WorkPackageCount
  include Sparql::Get::WorkPackages
  include Sparql::Queries::WorkPackages
  include Sparql::Get::WorkPackagesAll
  include Sparql::Queries::WorkPackagesAll
  include Sparql::Get::WorkPackageCountCurrent
  include Sparql::Queries::WorkPackageCountCurrent
  include Sparql::Get::WorkPackagesCurrent
  include Sparql::Queries::WorkPackagesCurrent
  include Sparql::Get::WorkPackagesCurrentAll
  include Sparql::Queries::WorkPackagesCurrentAll
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageBusinessItems
  include Sparql::Queries::WorkPackageBusinessItems
  include Sparql::Get::Response
  include Timeline::Timeline

  def index
  
    # The results returned depend upon the format requested ...
    # ... so we respond to different formats.
    respond_to do |format|
      
      # If the format requested is for HTML or RSS ...
      format.any( :html, :rss ) {
      
        # ... we get the page number passed as a parameter.
        page = params['page']
        @page = ( page || "1" ).to_i
    
        # We get the number of results per page passed as a parameter.
        results_per_page = params['results-per-page']
        @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
        # We get the count of all work packages.
        @result_count = get_work_package_count
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of work packages on this page with this many results per page.
        @work_packages = get_work_packages( @page, @results_per_page )
      
        # We set the page meta information.
        @page_title = 'Work packages'
        @multiline_page_title = "Work packages <span class='subhead'>All</span>".html_safe
        @description = 'All work packages.'
        @rss_url = work_package_list_url( :format => 'rss' )
        @csv_url = work_package_list_url( :format => 'csv' )
        @crumb << { label: 'Work packages', url: nil }
        @section = 'work-packages'
        @subsection = 'all'
      }
      
      # Otherwise, if the format requested is CSV.
      format.csv {
        @work_packages = get_work_packages_all
      }
    end
  end

  def index_search
    @search_term = params[:search]

    @work_packages = WorkPackage.fuzzy_search(@search_term)
    @result_count = @work_packages.size
    @results_per_page = @result_count

    # We set the page meta information.
    @page_title = 'Work packages'
    @multiline_page_title = "Work packages <span class='subhead'>All</span>".html_safe
    @description = 'All work packages.'
    @rss_url = work_package_list_url( :format => 'rss' )
    @csv_url = work_package_list_url( :format => 'csv' )
    @crumb << { label: 'Work packages', url: nil }
    @section = 'work-packages'
    @subsection = 'all'

    @page = 1

    render :index
  end
  
  def current
  
    @page_title = 'Work packages before Parliament'
  
    respond_to do |format|
      format.csv {
        @work_packages = get_work_packages_current_all
        response.headers['Content-Disposition'] = "attachment; filename=\"#{csv_title_from_page_title ( @page_title )}.csv\""
        render :template => 'work_package/index'
      }
      format.any( :html, :rss ) {
        # We get the page number passed as a parameter.
        page = params['page']
        @page = ( page || "1" ).to_i
    
        # We get the number of results per page passed as a parameter.
        results_per_page = params['results-per-page']
        @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
        # We get the count of all work packages.
        @result_count = get_work_package_current_count
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of work packages on this page with this many results per page.
        @work_packages = get_work_packages_current( @page, @results_per_page )
    
        @multiline_page_title = "Work packages <span class='subhead'>Before Parliament</span>".html_safe
        @description = 'Work packages before Parliament.'
        @csv_url = work_package_current_list_url( :format => 'csv' )
        @rss_url = work_package_current_list_url( :format => 'rss' )
        @crumb << { label: 'Work packages', url: work_package_list_url }
        @crumb << { label: 'Before Parliament', url: nil }
        @section = 'work-packages'
        @subsection = 'current'
      }
    end
  end

  def show
    work_package_id = params[:work_package]
    
    # We get the work package.
    @work_package = get_work_package( work_package_id )
    
    # If we find a work package with this identifier ...
    if @work_package
    
      # ... we get all the business items for the work package.
      @work_package_business_items = get_work_package_business_items( work_package_id )
    
      # We get arrays of pertinent past business items, future business items and undated business items.
      @work_package_pertinent_past_business_items = get_pertinent_business_items_of_type( @work_package_business_items, 'past' )
      @work_package_pertinent_future_business_item = get_pertinent_business_items_of_type( @work_package_business_items, 'future' )
      @work_package_pertinent_undated_business_item = get_pertinent_business_items_of_type( @work_package_business_items, 'undated' )
    
      # We construct arrays of past business items, future business items and undated business items structured for display as nested lists.
      # These are an array of dates, containing an array of business items, containing an array of steps.
      @work_package_past_business_items = construct_business_items_array_for_work_package( @work_package_pertinent_past_business_items )
      @work_package_future_business_items = construct_business_items_array_for_work_package( @work_package_pertinent_future_business_item )
      @work_package_undated_business_items = construct_business_items_array_for_work_package( @work_package_pertinent_undated_business_item )
    
      # We know the array of business items is actually an array of actualisations, some business items actualising more than one step.
      # We get the business item count.
      @business_item_count = get_business_item_count( @work_package_business_items )
    
      @page_title = "Work package for #{@work_package.work_packageable_thing_label}"
      @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package</span>".html_safe
      @description = "A work package for #{@work_package.work_packageable_thing_label}."
      @rss_url = work_package_business_item_list_url( :format => 'rss' )
      @crumb << { label: 'Work packages', url: work_package_list_url }
      @crumb << { label: @work_package.work_packageable_thing_label, url: nil }
      @section = 'work-packages'
    
      render :template => 'work_package_business_item/index'
    end
  end
end
