class ClockController < ApplicationController

  # We include modules required to get all clocks and a clock with its steps.
  include Sparql::Get::Clocks
  include Sparql::Queries::Clocks
  include Sparql::Get::Clock
  include Sparql::Queries::Clock
  include Sparql::Get::Response

  def index
    @clock = get_clocks
    
    @page_title = 'Clocks'
    @description = 'Clocks in procedures.'
    @crumb << { label: 'Clocks', url: nil }
    @section = 'clocks'
  end

  def show
    clock_id = params[:clock]
    @clock = get_clock( clock_id )
    
    #@page_title = 
    #@description = 
    @crumb << { label: 'Clocks', url: route_list_url }
    #@crumb << { label: , url: nil }
    @section = 'clocks'
  end
end
