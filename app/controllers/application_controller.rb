require 'open-uri'

class ApplicationController < ActionController::Base
  include LibraryDesign::Crumbs

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
