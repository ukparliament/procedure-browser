class WorkPackageableThing

  attr_accessor :work_package_identifier
  attr_accessor :procedure_identifier
  attr_accessor :procedure_label
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :event_date
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def procedure_id
    self.procedure_identifier.split( '/' ).last
  end
  
  def work_package_id
    self.work_package_identifier.split( '/' ).last
  end
end
