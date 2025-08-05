class ProcedureRouteController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureRoutes
  include Sparql::Queries::ProcedureRoutes
  include Sparql::Get::ProcedureSteps
  include Sparql::Queries::ProcedureSteps
  include Sparql::Get::Response
  include RouteChecker::RouteChecker

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_routes = get_procedure_routes( procedure_id )
    
    @page_title = "#{@procedure.label} - Routes"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Routes</span>".html_safe
    @description = "Routes present in #{@procedure.label}."
    @csv_url = procedure_route_list_url( :format => 'csv' )
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Routes', url: nil }
    @section = 'procedures'
    @subsection = 'routes'
  end
  
  def checker
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    procedure_routes = get_procedure_routes( procedure_id )
    procedure_steps = get_procedure_steps( procedure_id )
    
    # We create an array to report incorrect inbound and outbound route errors.
    @inbound_and_outbound_route_errors = []
    
    # For each step in the procedure ...
    procedure_steps.each do |step|
    
      # ... we check the inbound and outbound routes to the step.
      check_inbound_and_outbound_routes_to_step( step, procedure_routes )
    end
    
    @page_title = "#{@procedure.label} - Route checker"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Route checker</span>".html_safe
    @description = "Checking routes present in #{@procedure.label}."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Route checker', url: nil }
    @section = 'procedures'
    @subsection = 'route-checker'
  end
end

