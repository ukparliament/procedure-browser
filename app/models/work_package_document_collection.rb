class WorkPackageDocumentCollection
  include ActiveModel::Serialization
  attr_accessor :label, :work_package_document_list, :documents

  def attributes
    { "label" => nil }
  end
  
  def fragment_identifier
    self.label.downcase.gsub( ' ', '-' )
  end
end