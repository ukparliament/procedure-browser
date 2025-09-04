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
    letter = params[:letter]
    @letter = letter
    
    # We get the enabling legislation a to z.
    @letters = get_enabling_legislation_atoz
    
    # We get the enabling legislation items starting with that letter.
    @enabling_legislations = get_enabling_legislation_atoz_letter( @letter )
    
    @page_title = "Enabling legislation - #{@letter}"
    @multiline_page_title = "Enabling legislation <span class='subhead'>#{@letter.upcase}</span>".html_safe
    @description = "Legislation delegating powers, enabling one or more instruments subject to parliamentary procedure, starting with #{@letter.upcase}."
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    @crumb << { label: 'A to Z', url: enabling_legislation_atoz_list_url }
    @crumb << { label: @letter.upcase, url: nil }
    @section = 'enabling-legislation'
    @subsection = letter
  end
end
