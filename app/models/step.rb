# == Schema Information
#
# Table name: steps
#
#  id                                :bigint           not null, primary key
#  actualisation_count               :text
#  business_item_date                :text
#  business_item_identifier          :text
#  business_item_link                :text
#  calculation_style_identifier      :text
#  calculation_style_label           :text
#  commons_identifier                :text
#  date_note                         :text
#  depth                             :text
#  description                       :text
#  identifier                        :text
#  label                             :text
#  legislature_identifier            :text
#  legislature_label                 :text
#  link_note                         :text
#  lords_identifier                  :text
#  procedure_identifier              :text
#  procedure_label                   :text
#  publication_name                  :text
#  publication_url                   :text
#  scope_note                        :text
#  search_vector                     :tsvector
#  step_label                        :text
#  step_type_description             :text
#  step_type_identifier              :text
#  step_type_label                   :text
#  work_package_identifier           :text
#  work_package_made_available_on    :text
#  work_packageable_thing_identifier :text
#  work_packageable_thing_label      :text
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_steps_on_search_vector  (search_vector) USING gin
#
class Step < ApplicationRecord
  include PgSearch::Model

  SEARCH_ON = [
           :identifier,
           :label,
           :step_label,
           :description,
           :scope_note,
           :link_note,
           :date_note,
           :publication_name,
           :publication_url,
           :step_type_identifier,
           :step_type_label,
           :step_type_description,
           :commons_identifier,
           :lords_identifier,
           :legislature_identifier,
           :legislature_label,
           :business_item_identifier,
           :business_item_date,
           :business_item_link,
           :work_package_identifier,
           :work_package_made_available_on,
           :work_packageable_thing_identifier,
           :work_packageable_thing_label,
           :procedure_identifier,
           :procedure_label,
           :calculation_style_identifier,
           :calculation_style_label,
           :depth,
           :actualisation_count
              ]

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

  def id
    identifier.split( '/' ).last
  end
  
  def step_type_id
    step_type_identifier.split( '/' ).last
  end
  
  def commons_id
    commons_identifier.split( '/' ).last
  end
  
  def lords_id
    lords_identifier.split( '/' ).last
  end
  
  def legislature_id
    legislature_identifier.split( '/' ).last
  end
  
  def has_librarian_notes?
    has_librarian_notes = false
    if scope_note || link_note || date_note || publication_name || publication_url
      has_librarian_notes = true
    end
    has_librarian_notes
  end
  
  def display_label
    display_label = label
    display_label += ' ' + step_type_label unless step_type_id == 'Jwc6nqJi'
    display_label += house_or_legislature unless house_or_legislature.empty?
    display_label
  end
  
  def house_or_legislature
    house_or_legislature = ''
    houses_and_legislatures = []
    if commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if legislature_identifier
      houses_and_legislatures << legislature_label
    end
  
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          house_or_legislature += ', '
        else
          house_or_legislature += ' and '
        end
      end
      house_or_legislature += hl
    end
    house_or_legislature = ' (' + house_or_legislature + ')' unless house_or_legislature.empty?
    house_or_legislature
  end
end
