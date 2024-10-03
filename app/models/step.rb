class Step
  
  attr_accessor :identifier
  attr_accessor :label
  
  def id
    self.identifier.split( '/' ).last
  end
end
