


require 'sparql/get/all_steps'
require 'sparql/queries/all_steps'
require 'sparql/get_response'



class StepController < ApplicationController

  include ALL_STEPS_GET
  include ALL_STEPS_QUERY
  include GET_SPARQL_RESPONSE
  
  def index
    @steps = get_all_steps
  end
end
