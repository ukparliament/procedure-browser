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

  self.table_name = "organisations_accountable_to_parliament"

  def id
    identifier.split( '/' ).last
  end
end
