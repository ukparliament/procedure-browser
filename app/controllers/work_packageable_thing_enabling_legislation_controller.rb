class WorkPackageableThingEnablingLegislationController < ApplicationController

  # We include modules required to get a work packageable thing.
  include Sparql::Get::WorkPackageableThing
  include Sparql::Queries::WorkPackageableThing
  include Sparql::Get::WorkPackageableThingEnablingLegislations
  include Sparql::Queries::WorkPackageableThingEnablingLegislations
  include Sparql::Get::Response

  def index
    work_packageable_thing_id = params[:work_packageable_thing]
    @work_packageable_thing = get_work_packageable_thing( work_packageable_thing_id )
    
    @enabling_legislation = get_work_packageable_thing_enabling_legislation( work_packageable_thing_id )
    
    @page_title = "#{@work_packageable_thing.label} - enabling legislation"
    @multiline_page_title = "#{@work_packageable_thing.label} <span class='subhead'>Enabling legislation</span>".html_safe
    @description = "Legislation enabling the #{@work_packageable_thing.label}."
    @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
    @crumb << { label: @work_packageable_thing.label, url: work_packageable_thing_show_url }
    @crumb << { label: 'Enabling legislation', url: nil }
    @section = 'work-packages'
    @subsection = 'enabling-legislation'
  end
end
