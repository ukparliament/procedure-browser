class WorkPackage
  
  attr_accessor :identifier
  attr_accessor :work_packageable_thing_identifer
  attr_accessor :work_packageable_thing_label
  attr_accessor :making_available_identifier
  attr_accessor :made_available_on
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :calculation_style_identifier
  attr_accessor :calculation_style_label
  attr_accessor :has_committee_concerns
  attr_accessor :has_motion_tabled
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
  
  def work_packageable_thing_id
    self.work_packageable_thing_identifer.split( '/' ).last
  end
  
  def calculation_style_id
    self.calculation_style_identifier.split( '/' ).last
  end
end
