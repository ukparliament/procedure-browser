json.graph do
  json.id @procedure.id
  json.label @procedure.label
  json.directed true

  json.nodes do
    @steps.each do |step|
      json.set! step.id do
        json.label step.display_label
        json.metadata do
          json.step_type_id step.step_type_id
        end
      end
    end
  end

  json.edges @routes do |route|
    json.source route.from_step_id
    json.target route.to_step_id
    json.directed true
    json.metadata do
      json.is_open route.is_open
    end
  end
end


# step.identifier = row['step']
# step.label = row['stepName']
# step.description = row['description']
# step.legislature_identifier = row['legislature']
# step.legislature_label = row['legislatureName']
# step.commons_identifier = row['CommonsId']
# step.lords_identifier = row['LordsId']
# step.step_type_identifier = row['stepType']
# step.step_type_label = row['stepTypeLabel']


# route.identifier = row['Route']
# route.start_on = row['StartDate'].to_date if row['StartDate']
# route.end_on = row['EndDate'].to_date if row['EndDate']
# route.from_step_identifier = row['FromStep']
# route.from_step_label = row['FromStepName']
# route.from_step_type_identifier = row['FromStepType']
# route.from_step_type_label = row['FromStepTypeName']
# route.from_step_legislature_identifier = row['FromSteplegislature']
# route.from_step_legislature_label = row['FromSteplegislatureName']
# route.from_step_commons_identifier = row['FromStepCommonsId']
# route.from_step_lords_identifier = row['FromStepLordsId']
# route.to_step_identifier = row['ToStep']
# route.to_step_label = row['ToStepName']
# route.to_step_type_identifier = row['ToStepType']
# route.to_step_type_label = row['ToStepTypeName']
# route.to_step_legislature_identifier = row['ToSteplegislature']
# route.to_step_legislature_label = row['ToSteplegislatureName']
# route.to_step_commons_identifier = row['ToStepCommonsId']
# route.to_step_lords_identifier = row['ToStepLordsId']
