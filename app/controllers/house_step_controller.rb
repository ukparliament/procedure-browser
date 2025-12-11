class HouseStepController < ApplicationController

  # We include modules required to get a house and the steps in a house.
  include Sparql::Get::House
  include Sparql::Queries::House
  include Sparql::Get::HouseSteps
  include Sparql::Queries::HouseSteps
  include Sparql::Get::Response

  def index
    house_id = params[:house]
    @house = get_house( house_id )
    @house_steps = get_house_steps( house_id )
    
    @page_title = "Steps in the #{@house.label}"
    @multiline_page_title = "#{@house.label} <span class='subhead'>Steps</span>".html_safe
    @description = "Steps in the #{@house.label}."
    @canonical_url = house_show_url
    @crumb << { label: 'Legislatures', url: legislature_list_url }
    @crumb << { label: 'UK Parliament', url: legislature_show_url( :legislature => '4Mapsyb9') }
    @crumb << { label: @house.label, url: house_show_url( :house => @house.id ) }
    @crumb << { label: 'Steps', url: nil }
    @section = 'legislatures'
    @subsection = 'steps'
  end
end
