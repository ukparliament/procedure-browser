class TreatyController < ApplicationController

  # We include modules required to get all treaty procedures.
  include Sparql::Get::TreatyProcedures
  include Sparql::Queries::TreatyProcedures
  include Sparql::Get::Response

  def index
    @procedures = get_treaty_procedures
    
    @page_title = 'Treaties'
    @description = 'Treaties.'
    @crumb << { label: @page_title, url: nil }
  end
end
