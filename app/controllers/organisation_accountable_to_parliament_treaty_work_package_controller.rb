class OrganisationAccountableToParliamentTreatyWorkPackageController < ApplicationController

  # We include modules required to get an organisation accountable to Parliament and a paginated list of treaties led by that organisation.
  include Sparql::Get::OrganisationAccountableToParliament
  include Sparql::Queries::OrganisationAccountableToParliament
  include Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackageCount
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackageCount
  include Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackages
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackages
  include Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackagesAll
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackagesAll
  include Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackageCountCurrent
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackageCountCurrent
  include Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackagesCurrent
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackagesCurrent
  include Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackagesCurrentAll
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackagesCurrentAll
  include Sparql::Get::Response

  def index
  
    # We get the organisation accountable to Parliament.
    organisation_accountable_to_parliament = params[:organisation_accountable_to_parliament]
    @organisation_accountable_to_parliament = get_organisation_accountable_to_parliament( organisation_accountable_to_parliament )
  
    @page_title = "Work packages for treaties led by #{@organisation_accountable_to_parliament.label}"
    
    respond_to do |format|
      format.csv {
      
        # We get the set of treaties led by this organisation accountable to Parliament.
        @work_packages = get_organisation_accountable_to_parliament_treaty_work_packages_all( organisation_accountable_to_parliament ) 
      
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
    
        # We get the count of all treaties led by the organisation accountable to Parliament.
        @result_count = get_organisation_accountable_to_parliament_treaty_work_package_count( organisation_accountable_to_parliament )
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of treaties led by this organisation accountable to Parliament on this page with this many results per page.
        @work_packages = get_organisation_accountable_to_parliament_treaty_work_packages( organisation_accountable_to_parliament, @page, @results_per_page ) 
    
        @multiline_page_title = "#{@organisation_accountable_to_parliament.label} <span class='subhead'>All treaty work packages</span>".html_safe
        @description = "Work packages for treaties led by #{@organisation_accountable_to_parliament.label}."
        @rss_url = organisation_accountable_to_parliament_treaty_work_package_list_url( :format => 'rss' )
        @csv_url = organisation_accountable_to_parliament_treaty_work_package_list_url( :format => 'csv' )
        @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
        @crumb << { label: @organisation_accountable_to_parliament.label, url: organisation_accountable_to_parliament_show_url }
        @crumb << { label: 'Treaties', url: organisation_accountable_to_parliament_treaty_list_url }
        @crumb << { label: 'Work packages', url: nil }
        @section = 'organisations-accountable-to-parliament'
        @subsection = 'treaty-work-packages'
      }
    end
  end

  def current
  
    # We get the organisation accountable to Parliament.
    organisation_accountable_to_parliament = params[:organisation_accountable_to_parliament]
    @organisation_accountable_to_parliament = get_organisation_accountable_to_parliament( organisation_accountable_to_parliament )
  
    @page_title = "Work packages for treaties led by #{@organisation_accountable_to_parliament.label} before Parliament"
    
    respond_to do |format|
      format.csv {
      
        # We get the set of current treaties led by this organisation accountable to Parliament.
        @work_packages = get_organisation_accountable_to_parliament_treaty_work_packages_current_all( organisation_accountable_to_parliament ) 
      
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
    
        # We get the count of current treaties led by the organisation accountable to Parliament.
        @result_count = get_organisation_accountable_to_parliament_treaty_work_package_count_current( organisation_accountable_to_parliament )
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of current treaties led by this organisation accountable to Parliament on this page with this many results per page.
        @work_packages = get_organisation_accountable_to_parliament_treaty_work_packages_current( organisation_accountable_to_parliament, @page, @results_per_page ) 
    
        @multiline_page_title = "#{@organisation_accountable_to_parliament.label} <span class='subhead'>Treaty work packages before Parliament</span>".html_safe
        @description = "Work packages for treaties led by #{@organisation_accountable_to_parliament.label}, currently before Parliament."
        @rss_url = organisation_accountable_to_parliament_treaty_work_package_current_list_url( :format => 'rss' )
        @csv_url = organisation_accountable_to_parliament_treaty_work_package_current_list_url( :format => 'csv' )
        @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
        @crumb << { label: @organisation_accountable_to_parliament.label, url: organisation_accountable_to_parliament_show_url }
        @crumb << { label: 'Treaties', url: organisation_accountable_to_parliament_treaty_list_url }
        @crumb << { label: 'Work packages', url: organisation_accountable_to_parliament_treaty_work_package_list_url }
        @crumb << { label: 'Before Parliament', url: nil }
        @section = 'organisations-accountable-to-parliament'
        @subsection = 'treaty-work-packages-current'
      }
    end
  end
end
