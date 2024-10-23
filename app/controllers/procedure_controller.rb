class ProcedureController < ApplicationController

  # We include modules required to get all procedures and a procedure.
  include Sparql::Get::Procedures
  include Sparql::Queries::Procedures
  #include Sparql::Get::Procedure
  #include Sparql::Queries::Procedure
  include Sparql::Get::Response

  def index
    @procedures = get_procedures
    
    @page_title = 'Procedures'
    @description = 'Procedures.'
    @crumb << { label: 'Procedures', url: nil }
    @section = 'procedures'
  end

  def show
    @page_title = 'Coming soon'
    render :template => 'under_construction/notice'
  end
end
