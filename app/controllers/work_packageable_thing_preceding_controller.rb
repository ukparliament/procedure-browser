class WorkPackageableThingPrecedingController < ApplicationController

  # We include modules required to get work packageable thing.
  include Sparql::Get::WorkPackageableThing
  include Sparql::Queries::WorkPackageableThing
  include Sparql::Get::WorkPackageableThingPreceding
  include Sparql::Queries::WorkPackageableThingPreceding
  include Sparql::Get::Response

  def index
    work_packageable_thing_id = params[:work_packageable_thing]
    @work_packageable_thing = get_work_packageable_thing( work_packageable_thing_id )
    
    # If we find a work packageable thing with this identifier ...
    if @work_packageable_thing
    
      # ... we get any preceding work packageable things for this work packageable thing.
      @work_packageable_things = get_work_packageable_thing_preceding( work_packageable_thing_id )
    
      @page_title = "#{@work_packageable_thing.label} - preceding work packageable things"
      @multiline_page_title = "#{@work_packageable_thing.label} <span class='subhead'>Preceding work packageable things</span>".html_safe
      @description = "Preceding work packageable things for #{@work_packageable_thing.label}."
      @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
      @crumb << { label: @work_packageable_thing.label, url: work_packageable_thing_show_url }
      @crumb << { label: 'Preceding work packageable things', url: nil }
      @section = 'work-packages'
      @subsection = 'preceding'
    end
  end
end
