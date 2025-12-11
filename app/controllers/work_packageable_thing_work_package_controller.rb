class WorkPackageableThingWorkPackageController < ApplicationController

  # We include modules required to get work packageable thing.
  include Sparql::Get::WorkPackageableThing
  include Sparql::Queries::WorkPackageableThing
  include Sparql::Get::WorkPackageableThingWorkPackages
  include Sparql::Queries::WorkPackageableThingWorkPackages
  include Sparql::Get::Response

  def index
    work_packageable_thing_id = params[:work_packageable_thing]
    @work_packageable_thing = get_work_packageable_thing( work_packageable_thing_id )
    
    # We get all work packages for this work packageable thing.
    @work_packageable_thing_work_packages = get_work_packageable_thing_work_packages( work_packageable_thing_id )
    
    @page_title = "#{@work_packageable_thing.label} - work packages"
    @multiline_page_title = "#{@work_packageable_thing.label} <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages for #{@work_packageable_thing.label}."
    @canonical_url = work_packageable_thing_show_url
    @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
    @crumb << { label: @work_packageable_thing.label, url: work_packageable_thing_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'work-packages'
    @subsection = 'work-packages'
  end
end
