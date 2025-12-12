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
    @legislature_houses = get_legislature_houses( legislature_id )
    @legislature_steps = get_legislature_steps( legislature_id )
    
    @page_title = @legislature.label
    @description = "#{@legislature.label}."
    @csv_url = legislature_step_list_url( :format => 'csv' ) unless @legislature_steps.empty?
    @crumb << { label: 'Legislatures', url: legislature_list_url }
    @crumb << { label: @legislature.label, url: nil }
    @section = 'legislatures'
  end
end
