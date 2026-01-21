# == Schema Information
#
# Table name: organisations_accountable_to_parliament
#
#  id         :bigint           not null, primary key
#  end_on     :date
#  identifier :text
#  label      :text
#  start_on   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrganisationAccountableToParliament < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:label, :identifier]
  pg_search_scope :kinda_matching,
                  against: :text,
                  using: {
                    tsearch: {dictionary: "english"}
                  }
  # pg_search_scope :literally_matching,
  #                 against: :text,
  #                 using: {
  #                   tsearch: {dictionary: "simple"}
  #                 }

  self.table_name = "organisations_accountable_to_parliament"

  def id
    identifier.split( '/' ).last
  end
end
