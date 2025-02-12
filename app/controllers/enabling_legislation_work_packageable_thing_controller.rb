class EnablingLegislationWorkPackageableThingController < ApplicationController

  # We include modules required to a work package.
  include Sparql::Get::EnablingLegislation
  include Sparql::Queries::EnablingLegislation
  include Sparql::Get::EnablingLegislationWorkPackageableThings
  include Sparql::Queries::EnablingLegislationWorkPackageableThings
  include Sparql::Get::Response

  def index
    enabling_legislation = params[:enabling_legislation]
    @enabling_legislation = get_enabling_legislation( enabling_legislation )
    @enabling_legislation_work_packageable_things = get_enabling_legislation_work_packageable_things( enabling_legislation ) 
    
    
    
    
    
    
    
    
    
    #@page_title = @enabling_legislation.label
    #@description = "#{@enabling_legislation.label}."
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    #@crumb << { label: @enabling_legislation.label, url: nil }
    @section = 'enabling-legislation'
  end
end
