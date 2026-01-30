# == Schema Information
#
# Table name: enabling_legislations
#
#  id            :bigint           not null, primary key
#  act_number    :integer
#  date          :date
#  identifier    :text
#  label         :text
#  search_vector :tsvector
#  uri           :text
#  year          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_enabling_legislations_on_search_vector  (search_vector) USING gin
#
class EnablingLegislation < ApplicationRecord
  include PgSearch::Model

  SEARCH_ON = [:label, :identifier, :uri]

  multisearchable against: SEARCH_ON
  pg_search_scope :fuzzy_search,
                  against: SEARCH_ON,
                  using: {
                    tsearch: {
                      tsvector_column: "search_vector",
                      prefix: true,
                      dictionary: "english"
                    }
                  }

  def display_id
    identifier.split( '/' ).last
  end
end
