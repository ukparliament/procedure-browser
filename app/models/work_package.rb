# == Schema Information
#
# Table name: work_packages
#
#  id                               :bigint           not null, primary key
#  calculation_style_identifier     :text
#  calculation_style_label          :text
#  has_committee_concerns           :text
#  has_motion_tabled                :text
#  identifier                       :text
#  made_available_on                :date
#  making_available_identifier      :text
#  procedure_identifier             :text
#  procedure_label                  :text
#  work_packageable_thing_identifer :text
#  work_packageable_thing_label     :text
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
class WorkPackage < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [
                    :identifier,
                    :work_packageable_thing_identifer,
                    :work_packageable_thing_label,
                    :making_available_identifier,
                    :procedure_identifier,
                    :procedure_label,
                    :calculation_style_identifier,
                    :calculation_style_label
                  ]
  pg_search_scope :fuzzy_search,
                   against: [
                    :identifier,
                    :work_packageable_thing_identifer,
                    :work_packageable_thing_label,
                    :making_available_identifier,
                    :procedure_identifier,
                    :procedure_label,
                    :calculation_style_identifier,
                    :calculation_style_label
                  ],
                  using: {
                    tsearch: {
                      prefix: true,
                      dictionary: "english"
                    }
                  }

  def id
    identifier.split( '/' ).last
  end
  
  def procedure_id
    procedure_identifier.split( '/' ).last
  end
  
  def work_packageable_thing_id
    work_packageable_thing_identifer.split( '/' ).last
  end
  
  def calculation_style_id
    calculation_style_identifier.split( '/' ).last
  end
  
  def is_flagged?
    return true if has_committee_concerns || has_motion_tabled

    false
  end
end
