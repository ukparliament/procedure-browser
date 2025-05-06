class OrganisationAccountableToParliament
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :start_on
  attr_accessor :end_on
  
  def id
    self.identifier.split( '/' ).last
  end
end