class ProcedureStepBusinessItemController < ApplicationController

  # We include modules required to get a procedure, steps for a procedure and business items for a step in a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureStep
  include Sparql::Queries::ProcedureStep
  include Sparql::Get::ProcedureStepBusinessItems
  include Sparql::Queries::ProcedureStepBusinessItems
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    step_id = params[:step]
    @procedure_step = get_procedure_step( procedure_id, step_id )
    
    @procedure_step_business_items = get_procedure_step_business_items( procedure_id, step_id )
    
    @page_title = "#{@procedure.label} - Business items actualising '#{@procedure_step.label}'"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Business items actualising '#{@procedure_step.label}'</span>".html_safe
    @description = "Work packages subject to the #{@procedure.label} procedure, with business items actualising '#{@procedure_step.label}'."
    @rss_url = procedure_step_business_item_list_url( :format => 'rss' )
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Step types', url: procedure_step_type_list_url }
    @crumb << { label: @procedure_step.step_type_label, url: procedure_step_type_show_url( :step_type => @procedure_step.step_type_id ) }
    @crumb << { label: @procedure_step.label, url: procedure_step_show_url }
    @crumb << { label: 'Business items', url: nil }
    @section = 'procedures'
    @subsection = 'steps'
  end
end
