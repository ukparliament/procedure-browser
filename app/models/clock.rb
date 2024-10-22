class Clock
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :from_step_identifier
  attr_accessor :from_step_label
  attr_accessor :from_step_type_identifier
  attr_accessor :from_step_type_label
  attr_accessor :from_step_commons_identifier
  attr_accessor :from_step_lords_identifier
  attr_accessor :from_step_legislature_identifier
  attr_accessor :from_step_legislature_label
  attr_accessor :to_step_identifier
  attr_accessor :to_step_label
  attr_accessor :to_step_type_identifier
  attr_accessor :to_step_type_label
  attr_accessor :to_step_commons_identifier
  attr_accessor :to_step_lords_identifier
  attr_accessor :to_step_legislature_identifier
  attr_accessor :to_step_legislature_label
  attr_accessor :day_count
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def from_step_id
    self.from_step_identifier.split( '/' ).last
  end
  
  def from_step_type_id
    self.from_step_type_identifier.split( '/' ).last
  end
  
  def to_step_id
    self.to_step_identifier.split( '/' ).last
  end
  
  def to_step_type_id
    self.to_step_type_identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
end
