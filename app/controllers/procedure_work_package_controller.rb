class ProcedureWorkPackageController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureWorkPackageCount
  include Sparql::Queries::ProcedureWorkPackageCount
  include Sparql::Get::ProcedureWorkPackages
  include Sparql::Queries::ProcedureWorkPackages
  include Sparql::Get::ProcedureWorkPackagesAll
  include Sparql::Queries::ProcedureWorkPackagesAll
  include Sparql::Get::ProcedureWorkPackageCountCurrent
  include Sparql::Queries::ProcedureWorkPackageCountCurrent
  include Sparql::Get::ProcedureWorkPackagesCurrent
  include Sparql::Queries::ProcedureWorkPackagesCurrent
  include Sparql::Get::ProcedureWorkPackagesCurrentAll
  include Sparql::Queries::ProcedureWorkPackagesCurrentAll
  include Sparql::Get::Response

  def index
  
    # We get the procedure.
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    @page_title = "#{@procedure.label} - All work packages"
    
    respond_to do |format|
      format.csv {
        # We get the set of work packages for this procedure.
        @work_packages = get_procedure_work_packages_all( procedure_id )
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
    
        # We get the count of all work packages in the procedure.
        @result_count = get_procedure_work_package_count( procedure_id )
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of work packages for this procedure on this page with this many results per page.
        @work_packages = get_procedure_work_packages( procedure_id, @page, @results_per_page )
    
        @multiline_page_title = "#{@procedure.label} <span class='subhead'>All work packages</span>".html_safe
        @description = "All work packages subject to #{@procedure.label}."
        @rss_url = procedure_work_package_list_url( :format => 'rss' )
        @csv_url = procedure_work_package_list_url( :format => 'csv' )
        @crumb << { label: 'Procedures', url: procedure_list_url }
        @crumb << { label: @procedure.label, url: procedure_show_url }
        @crumb << { label: 'Work packages', url: nil }
        @section = 'procedures'
        @subsection = 'work-packages'
      }
    end
  end
  
  def current
  
    # We get the procedure.
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
  
    @page_title = "#{@procedure.label} - Work packages before Parliament"
    
    respond_to do |format|
      format.csv {
      
        # We get the set of work packages before Parliament for this procedure.
        @work_packages = get_procedure_work_packages_current_all( procedure_id )
      
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
    
        # We get the count of current work packages in the procedure.
        @result_count = get_procedure_work_package_current_count( procedure_id )
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of work packages for this procedure on this page with this many results per page.
        @work_packages = get_procedure_work_packages_current( procedure_id, @page, @results_per_page )
    
        @multiline_page_title = "#{@procedure.label} <span class='subhead'>Work packages before Parliament</span>".html_safe
        @description = "Work packages subject to #{@procedure.label} currently before Parliament."
        @canonical_url = procedure_show_url
        @rss_url = procedure_work_package_current_list_url( :format => 'rss' )
        @csv_url = procedure_work_package_current_list_url( :format => 'csv' )
        @crumb << { label: 'Procedures', url: procedure_list_url }
        @crumb << { label: @procedure.label, url: procedure_show_url }
        @crumb << { label: 'Work packages', url: procedure_work_package_list_url }
        @crumb << { label: 'Before Parliament', url: nil }
        @section = 'procedures'
        @subsection = 'work-packages-current'
      }
    end
  end
end
