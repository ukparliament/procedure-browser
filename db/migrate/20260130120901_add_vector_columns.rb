class AddVectorColumns < ActiveRecord::Migration[8.1]
  def change
    add_column :enabling_legislations, :search_vector, :tsvector
    add_column :work_packages, :search_vector, :tsvector
    add_column :organisations_accountable_to_parliament, :search_vector, :tsvector

    add_index :enabling_legislations, :search_vector, using: :gin
    add_index :work_packages, :search_vector, using: :gin
    add_index :organisations_accountable_to_parliament, :search_vector, using: :gin

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate_enabling_legislations BEFORE INSERT OR UPDATE
      ON enabling_legislations FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        search_vector, 'pg_catalog.english', #{EnablingLegislation::SEARCH_ON.map(&:to_s).join(", ")}
      );
    SQL

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate_work_packages BEFORE INSERT OR UPDATE
      ON work_packages FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        search_vector, 'pg_catalog.english', #{WorkPackage::SEARCH_ON.map(&:to_s).join(", ")}
      );
    SQL

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate_organisations BEFORE INSERT OR UPDATE
      ON organisations_accountable_to_parliament FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        search_vector, 'pg_catalog.english', #{OrganisationAccountableToParliament::SEARCH_ON.map(&:to_s).join(", ")}
      );
    SQL
  end
end
