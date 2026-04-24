class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Naive approach
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
end