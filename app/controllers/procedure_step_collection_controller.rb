class ProcedureStepCollectionController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureStepCollections
  include Sparql::Queries::ProcedureStepCollections
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    # If we find a procedure with this identifier ...
    if @procedure
      
      @procedure_step_collections = get_procedure_step_collections( procedure_id )
    
      @page_title = "#{@procedure.label} - Step collections"
      @multiline_page_title = "#{@procedure.label} <span class='subhead'>Step collections</span>".html_safe
      @description = "Step collections for #{@procedure.label}."
      @crumb << { label: 'Procedures', url: procedure_list_url }
      @crumb << { label: @procedure.label, url: procedure_show_url }
      @crumb << { label: 'Step collections', url: nil }
      @section = 'procedures'
      @subsection = 'step-collections'
    end
  end
end
