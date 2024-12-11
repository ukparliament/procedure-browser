class ProcedureStepWithDepthController < ApplicationController

  # We include modules required to get a procedure and business steps with depths in that procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureStepsWithDepths
  include Sparql::Queries::ProcedureStepsWithDepths
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_steps_with_depths = get_procedure_steps_with_depths( procedure_id )
    
    @page_title = "#{@procedure.label} - Steps with depths"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Steps with depths</span>".html_safe
    @description = "Steps present in #{@procedure.label} with depths."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Steps with depths', url: nil }
    @section = 'procedures'
    @subsection = 'steps-with-depths'
  end
end
