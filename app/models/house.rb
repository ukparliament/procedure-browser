class House
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :legislature_identifier
  attr_accessor :legislature_label
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def legislature_id
    self.legislature_identifier.split( '/' ).last
  end
end