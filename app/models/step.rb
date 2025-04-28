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
  
  def display_label
    display_label = self.label
    display_label += ' ' + self.step_type_label unless self.step_type_id == 'Jwc6nqJi'
    display_label += self.house_or_legislature unless self.house_or_legislature.empty?
    display_label
  end
  
  def house_or_legislature
    house_or_legislature = ''
    houses_and_legislatures = []
    if self.commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if self.lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if self.legislature_identifier
      houses_and_legislatures << self.legislature_label
    end
  
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          house_or_legislature += ', '
        else
          house_or_legislature += ' and '
        end
      end
      house_or_legislature += hl
    end
    house_or_legislature = ' (' + house_or_legislature + ')' unless house_or_legislature.empty?
    house_or_legislature
  end
end