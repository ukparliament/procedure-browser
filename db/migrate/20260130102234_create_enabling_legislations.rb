class CreateEnablingLegislations < ActiveRecord::Migration[8.1]
  def change
    create_table :enabling_legislations do |t|
      t.text      :identifier
      t.text      :label
      t.date      :date
      t.integer   :year
      t.integer   :act_number
      t.text      :uri

      t.timestamps
    end
  end
end

