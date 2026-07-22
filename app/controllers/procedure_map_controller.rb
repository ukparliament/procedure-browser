class ProcedureMapController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureSteps
  include Sparql::Queries::ProcedureSteps
  include Sparql::Get::ProcedureRoutes
  include Sparql::Queries::ProcedureRoutes
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    # If we find a procedure with this identifier ...
    if @procedure
    
      # We check which format the user has requested.
      respond_to do |format|
        
        # If the user has requested a .dot file.
        format.dot {
          
          # ... we get all the steps and the routes in the procedure.
          @steps = get_procedure_steps( procedure_id )
          @routes = get_procedure_routes( procedure_id )
          response.headers['Content-Disposition'] = "inline; filename=\"Procedure map for #{@procedure.label}.dot\""
        }
        
        # If the user has requested HTML ...
        format.html {
          
          # ... we set the page meta information
          @page_title = "#{@procedure.label} - Procedure map"
          @multiline_page_title = "#{@procedure.label} <span class='subhead'>Procedure map</span>".html_safe
          @description = "Procedure map for #{@procedure.label}."
          @dot_url = procedure_map_url( :format => 'dot' )
          @crumb << { label: 'Procedures', url: procedure_list_url }
          @crumb << { label: @procedure.label, url: procedure_show_url }
          @crumb << { label: 'Procedure map', url: nil }
          @section = 'procedures'
          @subsection = 'procedure-map'
          
          @steps = get_procedure_steps( procedure_id )
          @routes = get_procedure_routes( procedure_id )
        }
      end
    end
  end
end
