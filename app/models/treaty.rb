class Treaty
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :country_series_membership
  attr_accessor :country_series_membership_citation
  attr_accessor :european_union_series_membership
  attr_accessor :european_union_series_membership_citation
  attr_accessor :miscellaneous_series_membership
  attr_accessor :miscellaneous_series_membership_citation
  
  def id
    self.identifier.split( '/' ).last
  end
end