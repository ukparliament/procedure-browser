class RouteController < ApplicationController

  # We include modules required to get all routes and a routes with its steps.
  include Sparql::Get::Routes
  include Sparql::Queries::Routes
  include Sparql::Get::Route
  include Sparql::Queries::Route
  include Sparql::Get::Response

  def index
    @routes = get_routes
    
    @page_title = 'Routes'
    @description = 'Routes in procedures.'
    @crumb << { label: 'Routes', url: nil }
    @section = 'routes'
  end

  def show
    route_id = params[:route]
    @route = get_route( route_id )
    
    @page_title = @route.title
    @description = @route.description
    @crumb << { label: 'Routes', url: route_list_url }
    @crumb << { label: @route.crumb_label, url: nil }
    @section = 'routes'
  end
end
