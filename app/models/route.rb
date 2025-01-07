class Route
  
  attr_accessor :identifier
  attr_accessor :start_on
  attr_accessor :end_on
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :from_step_identifier
  attr_accessor :from_step_label
  attr_accessor :from_step_type_identifier
  attr_accessor :from_step_type_label
  attr_accessor :from_step_commons_identifier
  attr_accessor :from_step_lords_identifier
  attr_accessor :from_step_legislature_identifier
  attr_accessor :from_step_legislature_label
  attr_accessor :to_step_identifier
  attr_accessor :to_step_label
  attr_accessor :to_step_type_identifier
  attr_accessor :to_step_type_label
  attr_accessor :to_step_commons_identifier
  attr_accessor :to_step_lords_identifier
  attr_accessor :to_step_legislature_identifier
  attr_accessor :to_step_legislature_label
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
  
  def from_step_id
    self.from_step_identifier.split( '/' ).last
  end
  
  def from_step_type_id
    self.from_step_type_identifier.split( '/' ).last
  end
  
  def to_step_id
    self.to_step_identifier.split( '/' ).last
  end
  
  def to_step_type_id
    self.to_step_type_identifier.split( '/' ).last
  end
  
  def title
    title = 'Route from '
    title += self.from_step_full_label
    title += ' to '
    title += self.to_step_full_label
    title += ' as part of the '
    title += self.procedure_label
    title += ' procedure'
    title
  end
  
  def description
    description = 'A route from '
    description += self.from_step_full_label
    description += ' to '
    description += self.to_step_full_label
    description += ' as part of the '
    description += self.procedure_label
    description += ' procedure.'
    description
  end
  
  def crumb_label
    crumb_label = 'From '
    crumb_label += self.from_step_full_label
    crumb_label += ' to '
    crumb_label += self.to_step_full_label
    crumb_label += ' as part of the '
    crumb_label += self.procedure_label
    crumb_label += ' procedure'
    crumb_label
  end
  
  def from_step_full_label
    step_label = self.from_step_label
    step_label += ' ' + self.from_step_type_label unless self.from_step_type_id == 'Jwc6nqJi'
    step_label += self.from_step_house_or_legislature unless self.from_step_house_or_legislature.empty?
    step_label
  end
  
  def to_step_full_label
    step_label = self.to_step_label
    step_label += ' ' + self.to_step_type_label unless self.to_step_type_id == 'Jwc6nqJi'
    step_label += self.to_step_house_or_legislature unless self.to_step_house_or_legislature.empty?
    step_label
  end
  
  def from_step_house_or_legislature
    from_step_house_or_legislature = ''
    houses_and_legislatures = []
    if self.from_step_commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if self.from_step_lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if self.from_step_legislature_identifier
      houses_and_legislatures << self.from_step_legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          from_step_house_or_legislature += ', '
        else
          from_step_house_or_legislature += ' and '
        end
      end
      from_step_house_or_legislature += hl
    end
    from_step_house_or_legislature = ' (' + from_step_house_or_legislature + ')' unless from_step_house_or_legislature.empty?
    from_step_house_or_legislature
  end
  
  def to_step_house_or_legislature
    to_step_house_or_legislature = ''
    houses_and_legislatures = []
    if self.to_step_commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if self.to_step_lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if self.to_step_legislature_identifier
      houses_and_legislatures << self.to_step_legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          to_step_house_or_legislature += ', '
        else
          to_step_house_or_legislature += ' and '
        end
      end
      to_step_house_or_legislature += hl
    end
    to_step_house_or_legislature = ' (' + to_step_house_or_legislature + ')' unless to_step_house_or_legislature.empty?
    to_step_house_or_legislature
  end
end
