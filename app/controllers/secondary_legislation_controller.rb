class SecondaryLegislationController < ApplicationController

  # We include modules required to get all secondary legislation procedures.
  include Sparql::Get::SecondaryLegislationProcedures
  include Sparql::Queries::SecondaryLegislationProcedures
  include Sparql::Get::Response

  def index
    @procedures = get_secondary_legislation_procedures
    
    @page_title = 'Secondary legislation'
    @description = 'Secondary legislation.'
    @crumb << { label: @page_title, url: nil }
  end
end
