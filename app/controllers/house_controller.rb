class HouseController < ApplicationController

  # We include modules required to get all houses and a house.
  include Sparql::Get::Houses
  include Sparql::Queries::Houses
  include Sparql::Get::House
  include Sparql::Queries::House
  include Sparql::Get::HouseSteps
  include Sparql::Queries::HouseSteps
  include Sparql::Get::Response

  def index
    @houses = get_houses
    
    @page_title = 'Houses'
    @description = 'Houses.'
    @crumb << { label: 'Houses', url: nil }
    @section = 'legislatures'
  end

  def show
    house_id = params[:house]
    @house = get_house( house_id )
    @steps = get_house_steps( house_id )
    
    @page_title = @house.label
    @description = "#{@house.label}."
    @csv_url = house_step_list_url( :format => 'csv' ) unless @steps.empty?
    @crumb << { label: 'Legislatures', url: legislature_list_url }
    @crumb << { label: 'UK Parliament', url: legislature_show_url( :legislature => '4Mapsyb9') }
    @crumb << { label: @house.label, url: nil }
    @section = 'legislatures'
    @subsection = 'steps'
    
    render :template => 'house_step/index'
  end
end
