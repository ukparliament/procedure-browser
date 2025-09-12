class EnablingLegislationAtoZController < ApplicationController

  # We include modules required to get an a to z of enabling legislation and enabling legislation starting with a letter.
  include Sparql::Get::EnablingLegislationAtoz
  include Sparql::Queries::EnablingLegislationAtoz
  include Sparql::Get::EnablingLegislationAtozLetter
  include Sparql::Queries::EnablingLegislationAtozLetter
  include Sparql::Get::Response

  def index
    
    # We get the enabling legislation a to z.
    @letters = get_enabling_legislation_atoz
    
    @page_title = 'Enabling legislation - A to Z'
    @multiline_page_title = "Enabling legislation <span class='subhead'>A to Z</span>".html_safe
    @description = 'A to Z of legislation delegating powers, enabling one or more instruments subject to parliamentary procedure.'
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    @crumb << { label: 'A to Z', url: nil }
    @section = 'enabling-legislation'
  end
  
  def show
    @selected_letter = params[:letter]
    
    # We get the enabling legislation a to z.
    @letters = get_enabling_legislation_atoz
    
    # We get the enabling legislation items starting with that letter.
    @enabling_legislations = get_enabling_legislation_atoz_letter( @selected_letter )
    
    @page_title = "Enabling legislation - #{@selected_letter.upcase}"
    @multiline_page_title = "Enabling legislation <span class='subhead'>#{@selected_letter.upcase}</span>".html_safe
    @description = "Legislation delegating powers, enabling one or more instruments subject to parliamentary procedure, starting with #{@selected_letter.upcase}."
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    @crumb << { label: 'A to Z', url: enabling_legislation_atoz_list_url }
    @crumb << { label: @selected_letter.upcase, url: nil }
    @section = 'enabling-legislation'
    @subsection = @selected_letter
  end
end
