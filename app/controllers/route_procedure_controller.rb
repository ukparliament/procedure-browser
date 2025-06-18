class RouteProcedureController < ApplicationController

  # We include modules required to get a route with its steps and its procedures.
  include Sparql::Get::Route
  include Sparql::Queries::Route
  include Sparql::Get::RouteProcedures
  include Sparql::Queries::RouteProcedures
  include Sparql::Get::Response

  def index
    route_id = params[:route]
    @route = get_route( route_id )
    
    @procedures = get_route_procedures( route_id )
    
    @page_title = @route.title
    @description = @route.description
    @crumb << { label: 'Routes', url: route_list_url }
    @crumb << { label: @route.crumb_label, url: route_show_url }
    @crumb << { label: 'Procedures', url: nil }
    @section = 'routes'
  end
end
