class CreateWorkPackageDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :work_package_documents do |t|
      t.timestamps
    end
  end
end
