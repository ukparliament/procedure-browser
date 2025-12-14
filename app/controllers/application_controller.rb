require 'open-uri'

class ApplicationController < ActionController::Base

  include LibraryDesign::Crumbs

  $SITE_TITLE = 'Procedure Browser'
  $SPARQL_REQUEST_URI = URI( 'https://api.parliament.uk/sparql' )
  $SPARQL_REQUEST_HEADERS = { 'Content-Type': 'application/sparql-query' }
  $DATE_DISPLAY_FORMAT = '%-d %B %Y'
  $CSV_DATE_DISPLAY_FORMAT = '%-d/%m/%Y'
  $DEFAULT_RESULTS_PER_PAGE = 20
  
  $TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )
  $HAS_LIBRARIAN_MODE = ENV.fetch( "HAS_LIBRARIAN_MODE", 'false' )

  rescue_from ActionController::UnknownFormat, with: :unsupported_media_type

  before_action do
    #expires_in 3.minutes, :public => true
    create_queries_container
    register_mechanical_step_collections
  end
  
  def create_queries_container
    @queries = []
  end
  
  def register_mechanical_step_collections
    @mechanical_step_collections = ['pc94WzFV', 'TRohjSuI', 'RPfsm4lC', 'Oebb7fXv']
  end

  # For unmatched route in routes
  def route_not_found
    render file: "public/404.html", status: :not_found, layout: false
  end

  private
  
  def csv_title_from_page_title( page_title )
    page_title.downcase.gsub( ' ', '-' ).gsub( '---', '-' )
  end

  def render_404
    render file: "public/404.html", status: :not_found, layout: false
  end

  def unsupported_media_type
    render plain: 'Not supported', status: :unsupported_media_type
  end
end
