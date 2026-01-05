class HouseStepCollectionController < ApplicationController

  # We include modules required to get a house and the step collections of a house.
  include Sparql::Get::House
  include Sparql::Queries::House
  include Sparql::Get::HouseStepCollections
  include Sparql::Queries::HouseStepCollections
  include Sparql::Get::Response

  def index
    house_id = params[:house]
    @house = get_house( house_id )
    
    # If we find a house with this identifier ...
    if @house
    
      @house_step_collections = get_house_step_collections( house_id )
    
      @page_title = "Step collections for the #{@house.label}"
      @multiline_page_title = "#{@house.label} <span class='subhead'>Step collections</span>".html_safe
      @description = "Step collections for the #{@house.label}."
      @crumb << { label: 'Legislatures', url: legislature_list_url }
      @crumb << { label: 'UK Parliament', url: legislature_show_url( :legislature => '4Mapsyb9') }
      @crumb << { label: @house.label, url: house_show_url( :house => @house.id ) }
      @crumb << { label: 'Step collections', url: nil }
      @section = 'legislatures'
      @subsection = 'step-collections'
    end
  end
end
