class Procedure
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :description
  
  def id
    self.identifier.split( '/' ).last
  end
end
