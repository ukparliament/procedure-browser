class CreateOrganisationsAccountableToParliament < ActiveRecord::Migration[8.1]
  def change
    create_table :organisations_accountable_to_parliament do |t|
      t.text      :identifier
      t.text      :label
      t.date      :start_on
      t.date      :end_on
      t.timestamps
    end
  end
end
