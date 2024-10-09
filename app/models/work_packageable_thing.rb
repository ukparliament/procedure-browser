class WorkPackageableThing

  attr_accessor :work_package_identifier
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :identifier
  attr_accessor :label
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
end
