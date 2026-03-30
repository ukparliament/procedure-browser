# We include code required.
require 'uri'
require 'net/http'
require 'csv'

module Sparql::Get::Response
  
  # A method to get a response from SPARQL as a CSV.
  def get_sparql_response_as_csv( request )
    # We add the SPARQL query request to the array of queries.
    @queries << request
    
    # If the request is an array ...
    # ... we know the array is formed of a title, a link and the query ...
    if request.kind_of?( Array )
    
      # ... so we set the request body to the third item in the array, being the query.
      request_body = request[2]
    
    # Otherwise, if the request is a string ...
    # ... we know the request is formed of the request body ...
    elsif  request.kind_of?( String )
    
      # ... so we set up the request body to be the request string.
      request_body = request
      
    # Otherwise, if the request is neither a string nor an array ...
    else
    
      # ... we raise an error.
      raise 'error'
    end
    
    # We get the response from the SPARQL query.
    response = call_api(request_body)

    # Let's make sure the response body is actually UTF-8
    body = convert_response_body_to_utf_8(response)

    # We parse the body of the response as CSV.
    CSV.parse(body, headers: true)
  end

  def call_api(request_body)
    Net::HTTP.post($SPARQL_REQUEST_URI, request_body, $SPARQL_REQUEST_HEADERS)
  end

  def convert_response_body_to_utf_8(response)
    body = response.body
    body.force_encoding('UTF-8').encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
  end
end