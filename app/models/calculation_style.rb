class CalculationStyle
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :egg_timer_id
  
  def id
    self.identifier.split( '/' ).last
  end
end
