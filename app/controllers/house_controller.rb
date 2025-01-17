class HouseController < ApplicationController

  # We include modules required to get all legislatures and a legislature.
  include Sparql::Get::Houses
  include Sparql::Queries::Houses
  include Sparql::Get::Response

  def index
    @houses = get_houses
    
    @page_title = 'Houses'
    @description = 'Houses.'
    @crumb << { label: 'Houses', url: nil }
    @section = 'houses'
  end

  def show
    @page_title = 'Coming soon'
    render :template => 'under_construction/notice'
  end
end
