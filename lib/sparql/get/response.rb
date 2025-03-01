# We include code required.
require 'uri'
require 'net/http'
require 'csv'

module Sparql::Get::Response
  
  # A method to get a response from SPARQL as a CSV.
  def get_sparql_response_as_csv( request_body )
  
    # We add the SPARQL query request body to the array of queries.
    @queries << request_body
  
    # We get the response from the SPARQL query.
    response = Net::HTTP.post( $SPARQL_REQUEST_URI, request_body, $SPARQL_REQUEST_HEADERS )
    
    # We parse the body of the response as CSV.
    CSV.parse( response.body, headers: true )
  end
end