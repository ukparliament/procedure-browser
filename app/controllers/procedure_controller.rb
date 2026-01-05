class ProcedureController < ApplicationController

  # We include modules required to get all procedures and a procedure.
  include Sparql::Get::Procedures
  include Sparql::Queries::Procedures
  include Sparql::Get::ProceduresMain
  include Sparql::Queries::ProceduresMain
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureWorkPackageCountCurrent
  include Sparql::Queries::ProcedureWorkPackageCountCurrent
  include Sparql::Get::ProcedureWorkPackagesCurrent
  include Sparql::Queries::ProcedureWorkPackagesCurrent
  include Sparql::Get::Response

  def index
    @procedures = get_procedures
    
    @page_title = 'Procedures'
    @multiline_page_title = "Procedures <span class='subhead'>All</span>".html_safe
    @description = 'Procedures.'
    @crumb << { label: 'Procedures', url: nil }
    @section = 'procedures'
    @subsection = 'all'
  end

  def main
    @procedures = get_main_procedures
    
    @page_title = 'Procedures'
    @multiline_page_title = "Procedures".html_safe
    @description = 'Procedures.'
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: 'Main', url: nil }
    @section = 'procedures'
    @subsection = 'main'
  end

  def show
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    # If we find a procedure with this identifier ...
    if @procedure
  
      # ... we get the page number passed as a parameter.
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
    
      @page_title = @procedure.label
      @description = @procedure.description
      @rss_url = procedure_work_package_current_list_url( :format => 'rss' )
      @csv_url = procedure_work_package_current_list_url( :format => 'csv' )
      @crumb << { label: 'Procedures', url: procedure_list_url }
      @crumb << { label: @procedure.label, url: nil }
      @section = 'procedures'
      @subsection = 'work-packages-current'
    
      render :template => 'procedure_work_package/current'
    end
  end
end
