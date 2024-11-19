class ProcedureRouteController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureRoutes
  include Sparql::Queries::ProcedureRoutes
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_routes = get_procedure_routes( procedure_id )
    
    @page_title = "#{@procedure.label} - Routes"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Routes</span>".html_safe
    @description = "Routes present in #{@procedure.label}."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Routes', url: nil }
    @section = 'procedures'
    @subsection = 'routes'
  end
end
