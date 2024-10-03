class Step
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :description
  attr_accessor :scope_note
  attr_accessor :link_note
  attr_accessor :date_note
  attr_accessor :publication_name
  attr_accessor :publication_url
  attr_accessor :step_type_identifier
  attr_accessor :step_type_label
  
  def id
    self.identifier.split( '/' ).last
  end
end
