module EnablingLegislationWorkPackageableThingHelper

  def enabling_legislation_work_packageable_thing_results_per_page_link( number, results_per_page )
    if number == results_per_page
      number.to_s
    else
      link_to( number.to_s, enabling_legislation_work_packageable_thing_list_url( 'results-per-page' => number ) )
    end
  end
end
