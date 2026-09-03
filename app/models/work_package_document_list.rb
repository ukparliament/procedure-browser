class WorkPackageDocumentList
  include ActiveModel::Serialization
  attr_accessor :label, :work_package_document_collections # Emulate has_many :notwork_package_document_collections

  def attributes
    { :label => 'lala', :work_package_document_collections => nil }
  end
end


