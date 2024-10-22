class Procedure
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :description
  attr_accessor :step_display_depth_value
  
  def id
    self.identifier.split( '/' ).last
  end
end
