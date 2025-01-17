class LegislatureController < ApplicationController

  # We include modules required to get all legislatures and a legislature.
  include Sparql::Get::Legislatures
  include Sparql::Queries::Legislatures
  #include Sparql::Get::Legislature
  #include Sparql::Queries::Legislature
  include Sparql::Get::Response

  def index
    @legislatures = get_legislatures
    
    @page_title = 'Legislatures'
    @description = 'Legislatures.'
    @crumb << { label: 'Legislatures', url: nil }
    @section = 'legislatures'
  end

  def show
    @page_title = 'Coming soon'
    render :template => 'under_construction/notice'
  end
end
