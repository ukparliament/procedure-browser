class LegislatureController < ApplicationController

  # We include modules required to get all legislatures and a legislature.
  include Sparql::Get::Legislatures
  include Sparql::Queries::Legislatures
  include Sparql::Get::Legislature
  include Sparql::Queries::Legislature
  include Sparql::Get::LegislatureHouses
  include Sparql::Queries::LegislatureHouses
  include Sparql::Get::LegislatureSteps
  include Sparql::Queries::LegislatureSteps
  include Sparql::Get::Response

  def index
    @legislatures = get_legislatures
    
    @page_title = 'Legislatures'
    @description = 'Legislatures.'
    @crumb << { label: 'Legislatures', url: nil }
    @section = 'legislatures'
  end

  def show
    legislature_id = params[:legislature]
    @legislature = get_legislature( legislature_id )
    
    # If we find a legislature with this identifier ...
    if @legislature
    
      # We get an array of Houses in the legislature, if any.
      @legislature_houses = get_legislature_houses( legislature_id )
      
      # We create an empty array of steps.
      @steps = []
      
      # The UK Parliament has two Houses but no steps directly associated.
      # Therefore, if the array of houses is empty ...
      if @legislature_houses.empty?
      
        # ... we get the array of steps in the legislature.
        @steps = get_legislature_steps( legislature_id )
      end
    
      @page_title = @legislature.label
      @description = "#{@legislature.label}."
      @csv_url = legislature_step_list_url( :format => 'csv' ) unless @steps.empty?
      @crumb << { label: 'Legislatures', url: legislature_list_url }
      @crumb << { label: @legislature.label, url: nil }
      @section = 'legislatures'
    end
  end
end
