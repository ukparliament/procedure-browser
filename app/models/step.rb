class Step
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :step_label
  attr_accessor :description
  attr_accessor :scope_note
  attr_accessor :link_note
  attr_accessor :date_note
  attr_accessor :publication_name
  attr_accessor :publication_url
  attr_accessor :step_type_identifier
  attr_accessor :step_type_label
  attr_accessor :step_type_description
  attr_accessor :commons_identifier
  attr_accessor :lords_identifier
  attr_accessor :legislature_identifier
  attr_accessor :legislature_label
  attr_accessor :business_item_identifier
  attr_accessor :business_item_date
  attr_accessor :business_item_link
  attr_accessor :work_package_identifier
  attr_accessor :work_package_made_available_on
  attr_accessor :work_packageable_thing_identifier
  attr_accessor :work_packageable_thing_label
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :calculation_style_identifier
  attr_accessor :calculation_style_label
  attr_accessor :depth
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def step_type_id
    self.step_type_identifier.split( '/' ).last
  end
  
  def commons_id
    self.commons_identifier.split( '/' ).last
  end
  
  def lords_id
    self.lords_identifier.split( '/' ).last
  end
  
  def legislature_id
    self.legislature_identifier.split( '/' ).last
  end
  
  def has_librarian_notes?
    has_librarian_notes = false
    if self.scope_note || self.link_note || self.date_note || self.publication_name || self.publication_url
      has_librarian_notes = true
    end
    has_librarian_notes
  end
end