class CreateSteps < ActiveRecord::Migration[8.1]
  def up
    create_table :steps do |t|
      t.text :identifier
      t.text :label
      t.text :step_label
      t.text :description
      t.text :scope_note
      t.text :link_note
      t.text :date_note
      t.text :publication_name
      t.text :publication_url
      t.text :step_type_identifier
      t.text :step_type_label
      t.text :step_type_description
      t.text :commons_identifier
      t.text :lords_identifier
      t.text :legislature_identifier
      t.text :legislature_label
      t.text :business_item_identifier
      t.text :business_item_date
      t.text :business_item_link
      t.text :work_package_identifier
      t.text :work_package_made_available_on
      t.text :work_packageable_thing_identifier
      t.text :work_packageable_thing_label
      t.text :procedure_identifier
      t.text :procedure_label
      t.text :calculation_style_identifier
      t.text :calculation_style_label
      t.text :depth
      t.text :actualisation_count
      t.tsvector :search_vector

      t.timestamps
    end

    add_index :steps, :search_vector, using: :gin

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate_steps BEFORE INSERT OR UPDATE
      ON steps FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        search_vector, 'pg_catalog.english', #{Step::SEARCH_ON.map(&:to_s).join(", ")}
      );
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate_steps
      ON steps
    SQL

    remove_index :steps, :search_vector

    drop_table :steps
  end
end




