class SecondaryLegislationController < ApplicationController

  # We include modules required to get all routes and a routes with its steps and procedures.
  include Sparql::Get::SecondaryLegislationProcedures
  include Sparql::Queries::SecondaryLegislationProcedures
  include Sparql::Get::Response

  def index
    @procedures = get_secondary_legislation_procedures
    
    @page_title = 'Secondary legislation'
    @description = 'Secondary legislation.'
    @crumb << { label: 'Secondary legislation', url: nil }
  end
end
