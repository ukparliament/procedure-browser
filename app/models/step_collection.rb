class StepCollection
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :house_identifier
  attr_accessor :house_label
  attr_accessor :membership_identifier
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
  
  def house_id
    self.house_identifier.split( '/' ).last
  end
end
