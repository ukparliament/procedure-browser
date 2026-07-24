require 'open-uri'

class BusinessItem
  
  attr_accessor :identifier
  attr_accessor :date
  attr_accessor :link
  attr_accessor :step_identifier
  attr_accessor :step_label
  attr_accessor :legislature_identifier
  attr_accessor :legislature_label
  attr_accessor :commons_identifier
  attr_accessor :lords_identifier
  attr_accessor :work_package_identifier
  attr_accessor :work_package_made_available_on
  attr_accessor :work_packageable_thing_identifier
  attr_accessor :work_packageable_thing_label
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :calculation_style_identifier
  attr_accessor :calculation_style_label
  attr_accessor :is_committee_correspondence
  attr_accessor :is_government_response_to_select_commmittee_report
  attr_accessor :is_ministerial_statement
  attr_accessor :is_committee_oral_evidence_session
  attr_accessor :is_associated_paper
  attr_accessor :is_debate
  attr_accessor :is_committee_concerns
  attr_accessor :is_upgrade_to_affirmative
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def step_id
    self.step_identifier.split( '/' ).last
  end
  
  def work_package_id
    self.work_package_identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
  
  def calculation_style_id
    self.calculation_style_identifier.split( '/' ).last
  end
  
  def commons_id
    self.commons_identifier.split( '/' ).last
  end
  
  def lords_id
    self.lords_identifier.split( '/' ).last
  end
  
  def legislature_id
    self.legislature_identifier.split( '/' ).last
  end
  
  def work_package_id
    self.work_package_identifier.split( '/' ).last
  end
  
  def work_packageable_thing_id
    self.work_packageable_thing_identifier.split( '/' ).last
  end
  
  def link_domain
    uri = URI.parse( self.link )
    uri.host
  end
end
