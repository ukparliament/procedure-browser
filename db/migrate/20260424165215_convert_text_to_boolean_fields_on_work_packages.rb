class ConvertTextToBooleanFieldsOnWorkPackages < ActiveRecord::Migration[8.1]
  def change
    change_column :work_packages, :has_committee_concerns, :boolean, using: "has_committee_concerns::boolean", default: false
    change_column :work_packages, :has_motion_tabled, :boolean, using: "has_motion_tabled::boolean", default: false
  end
end
