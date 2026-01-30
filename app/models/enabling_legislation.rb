# == Schema Information
#
# Table name: enabling_legislations
#
#  id         :bigint           not null, primary key
#  act_number :integer
#  date       :date
#  identifier :text
#  label      :text
#  uri        :text
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class EnablingLegislation < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:label, :identifier, :year, :uri]
  pg_search_scope :fuzzy_search,
                  against: [:label, :identifier, :year, :uri],
                  using: {
                    tsearch: {
                      prefix: true,
                      dictionary: "english"
                    }
                  }

  def display_id
    identifier.split( '/' ).last
  end
end
