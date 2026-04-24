class CreateWorkPackages < ActiveRecord::Migration[8.1]
  def change
    create_table :work_packages do |t|
      t.text  :identifier
      t.text  :work_packageable_thing_identifer
      t.text  :work_packageable_thing_label
      t.text  :making_available_identifier
      t.date  :made_available_on
      t.text  :procedure_identifier
      t.text  :procedure_label
      t.text  :calculation_style_identifier
      t.text  :calculation_style_label
      t.text  :has_committee_concerns
      t.text  :has_motion_tabled
      t.timestamps
    end
  end
end



