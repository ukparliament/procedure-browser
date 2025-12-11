class LegislatureHouseController < ApplicationController

  # We include modules required to get a legislature and the houses in a legislature.
  include Sparql::Get::Legislature
  include Sparql::Queries::Legislature
  include Sparql::Get::LegislatureHouses
  include Sparql::Queries::LegislatureHouses
  include Sparql::Get::Response

  def index
    legislature_id = params[:legislature]
    @legislature = get_legislature( legislature_id )
    @legislature_houses = get_legislature_houses( legislature_id )
    
    @page_title = "Houses in the #{@legislature.label}"
    @multiline_page_title = "#{@legislature.label} <span class='subhead'>Houses</span>".html_safe
    @description = "Houses in the #{@legislature.label}."
    @canonical_url = legislature_show_url
    @crumb << { label: 'Legislatures', url: legislature_list_url }
    @crumb << { label: @legislature.label, url: legislature_show_url }
    @crumb << { label: 'Houses', url: nil }
    @section = 'legislatures'
  end
end
