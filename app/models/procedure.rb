class Procedure
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :description
  attr_accessor :display_order
  attr_accessor :start_on
  attr_accessor :end_on
  attr_accessor :step_display_depth_value
  attr_accessor :calculation_style_identifer
  attr_accessor :calculation_style_label
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def calculation_style_id
    self.calculation_style_identifer.split( '/' ).last
  end
end
