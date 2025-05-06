class Treaty
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :laid_on
  attr_accessor :series_citation
  
  def id
    self.identifier.split( '/' ).last
  end
end