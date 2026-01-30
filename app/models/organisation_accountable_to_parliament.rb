# == Schema Information
#
# Table name: organisations_accountable_to_parliament
#
#  id            :bigint           not null, primary key
#  end_on        :date
#  identifier    :text
#  label         :text
#  search_vector :tsvector
#  start_on      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_organisations_accountable_to_parliament_on_search_vector  (search_vector) USING gin
#
class OrganisationAccountableToParliament < ApplicationRecord
  include PgSearch::Model

  SEARCH_ON = [:label, :identifier]

  multisearchable against: SEARCH_ON
  pg_search_scope :fuzzy_search,
                  against: SEARCH_ON,
                  using: {
                    tsearch: {
                      column: :search_vector,
                      prefix: true,
                      dictionary: "english"
                    }
                  }

  self.table_name = "organisations_accountable_to_parliament"

  scope :current, -> { where(end_on: nil) }

  def id
    identifier.split( '/' ).last
  end
end
