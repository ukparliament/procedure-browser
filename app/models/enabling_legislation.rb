class EnablingLegislation
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :date
  attr_accessor :year
  attr_accessor :act_number
  attr_accessor :uri
  
  def id
    self.identifier.split( '/' ).last
  end
end