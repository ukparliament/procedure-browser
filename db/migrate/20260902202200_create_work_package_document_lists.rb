class CreateWorkPackageDocumentLists < ActiveRecord::Migration[8.1]
  def change
    create_table :work_package_document_lists do |t|
      t.timestamps
    end
  end
end
