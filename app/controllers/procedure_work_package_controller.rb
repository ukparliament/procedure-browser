class ProcedureWorkPackageController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureWorkPackages
  include Sparql::Queries::ProcedureWorkPackages
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_work_packages = get_procedure_work_packages( procedure_id )
    
    @page_title = "#{@procedure.label} - Work packages"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages subject to #{@procedure.label}."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'procedures'
    @subsection = 'work-packages'
  end
end
