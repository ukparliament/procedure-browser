require 'open-uri'

class ApplicationController < ActionController::Base

  $SPARQL_REQUEST_URI = URI( 'https://api.parliament.uk/sparql' )
  $SPARQL_REQUEST_HEADERS = { 'Content-Type': 'application/sparql-query' }
  $DATE_DISPLAY_FORMAT = '%-d %B %Y'
  $DEFAULT_RESULTS_PER_PAGE = 20

  rescue_from ActionController::UnknownFormat, with: :unsupported_media_type

  before_action do
    #expires_in 3.minutes, :public => true
    create_crumb_container
    create_queries_container
  end
  
  def create_crumb_container
    @crumb = []
  end
  
  def create_queries_container
    @queries = []
  end

  # For unmatched route in routes
  def route_not_found
    render file: "public/404.html", status: :not_found, layout: false
  end

  private

  def render_404
    render file: "public/404.html", status: :not_found, layout: false
  end

  def unsupported_media_type
    render plain: 'Not supported', status: :unsupported_media_type
  end
end
