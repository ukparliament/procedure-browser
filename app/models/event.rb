class Event
  
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
  attr_accessor :work_packageable_thing_identifier
  attr_accessor :work_packageable_thing_label
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  
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
  
  def commons_id
    self.commons_identifier.split( '/' ).last
  end
  
  def lords_id
    self.lords_identifier.split( '/' ).last
  end
  
  def legislature_id
    self.legislature_identifier.split( '/' ).last
  end
end
