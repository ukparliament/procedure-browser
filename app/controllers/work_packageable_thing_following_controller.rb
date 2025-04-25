class WorkPackageableThingFollowingController < ApplicationController

  # We include modules required to get work packageable thing.
  include Sparql::Get::WorkPackageableThing
  include Sparql::Queries::WorkPackageableThing
  include Sparql::Get::WorkPackageableThingFollowing
  include Sparql::Queries::WorkPackageableThingFollowing
  include Sparql::Get::Response

  def index
    work_packageable_thing_id = params[:work_packageable_thing]
    @work_packageable_thing = get_work_packageable_thing( work_packageable_thing_id )
    
    @work_packageable_things = get_work_packageable_thing_following( work_packageable_thing_id )
    
    @page_title = "#{@work_packageable_thing.label} - following work packageable things"
    @multiline_page_title = "#{@work_packageable_thing.label} <span class='subhead'>Following work packageable things</span>".html_safe
    @description = "Following work packageable things for #{@work_packageable_thing.label}."
    @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
    @crumb << { label: @work_packageable_thing.label, url: work_packageable_thing_show_url }
    @crumb << { label: 'Following work packageable things', url: nil }
    @section = 'work-packageable-things'
    @subsection = 'following'
  end
end
