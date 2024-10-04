class ApplicationController < ActionController::Base

  $SPARQL_REQUEST_URI = URI( 'https://api.parliament.uk/sparql' )
  $SPARQL_REQUEST_HEADERS = { 'Content-Type': 'application/sparql-query' }
  

  before_action do
    #expires_in 3.minutes, :public => true
    create_crumb_container
  end
  
  def create_crumb_container
    @crumb = []
  end
end
