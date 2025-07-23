class ProcedureController < ApplicationController

  # We include modules required to get all procedures and a procedure.
  include Sparql::Get::Procedures
  include Sparql::Queries::Procedures
  include Sparql::Get::ProceduresMain
  include Sparql::Queries::ProceduresMain
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
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
    
    @page_title = @procedure.label
    @description = @procedure.description
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: nil }
    @section = 'procedures'
    @subsection = 'overview'
  end
end
