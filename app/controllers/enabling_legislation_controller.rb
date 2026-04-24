class EnablingLegislationController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::EnablingLegislationAtoz
  include Sparql::Queries::EnablingLegislationAtoz
  include Sparql::Get::EnablingLegislations
  include Sparql::Queries::EnablingLegislations
  include Sparql::Get::EnablingLegislation
  include Sparql::Queries::EnablingLegislation
  include Sparql::Get::EnablingLegislationWorkPackageCountCurrent
  include Sparql::Queries::EnablingLegislationWorkPackageCountCurrent
  include Sparql::Get::EnablingLegislationWorkPackagesCurrent
  include Sparql::Queries::EnablingLegislationWorkPackagesCurrent
  include Sparql::Get::Response

  def index
    
    # We get the enabling legislation items.
    @enabling_legislations = get_enabling_legislations
    
    respond_to do |format|
      format.csv
      format.html {
      
        # We get the enabling legislation a to z.
        @letters = get_enabling_legislation_atoz
        
        @page_title = 'Enabling legislation'
        @multiline_page_title = "Enabling legislation <span class='subhead'>All</span>".html_safe
        @description = 'Legislation delegating powers, enabling one or more instruments subject to parliamentary procedure.'
        @csv_url = enabling_legislation_list_url( :format => 'csv' )
        @crumb << { label: 'Enabling legislation', url: nil }
        @section = 'enabling-legislation'
        @subsection = 'all'
      }
    end
  end

  def index_search
    @search_term = params[:search]

    @enabling_legislations = EnablingLegislation.fuzzy_search(@search_term)
    @result_count = @enabling_legislations.size

    respond_to do |format|
      format.csv {}
      format.html {
        @page_title = 'Enabling legislation'
        @multiline_page_title = "Enabling legislation <span class='subhead'>All</span>".html_safe
        @description = 'Legislation delegating powers, enabling one or more instruments subject to parliamentary procedure.'
        @csv_url = enabling_legislation_list_url( :format => 'csv' )
        @crumb << { label: 'Enabling legislation', url: nil }
        @section = 'enabling-legislation'
        @subsection = 'all'
      }
    end

    render :index
  end

  def show
  
    # We get the enabling legislation.
    enabling_legislation = params[:enabling_legislation]
    @enabling_legislation = get_enabling_legislation( enabling_legislation )
    
    # If we find an item of enabling legislation with this identifier ...
    if @enabling_legislation
  
      # ... we get the page number passed as a parameter.
      page = params['page']
      @page = ( page || "1" ).to_i
    
      # We get the number of results per page passed as a parameter.
      results_per_page = params['results-per-page']
      @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
      # We get the count of all work packages for the item of enabling legislation.
      @result_count = get_enabling_legislation_work_package_count_current( enabling_legislation )
    
      # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
      if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
        raise ActionController::RoutingError.new("Not Found")
      end
    
      # We get the set of work packages for an item of legislation on this page with this many results per page.
      @work_packages = get_enabling_legislation_work_packages_current( enabling_legislation, @page, @results_per_page ) 
    
      @page_title = "#{@enabling_legislation.label} - work packages before Parliament"
      @multiline_page_title = "#{@enabling_legislation.label} <span class='subhead'>Work packages before Parliament</span>".html_safe
      @description = "Work packages for instruments enabled by #{@enabling_legislation.label} currently before Parliament."
      @rss_url = enabling_legislation_work_package_current_list_url( :format => 'rss' )
      @csv_url = enabling_legislation_work_package_current_list_url( :format => 'csv' )
      @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
      @crumb << { label: @enabling_legislation.label, url: nil }
      @section = 'enabling-legislation'
      @subsection = 'work-packages-current'
    
      render :template => 'enabling_legislation_work_package/current'
    end
  end
end
