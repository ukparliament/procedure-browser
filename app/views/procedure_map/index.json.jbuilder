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
          json.identifier step.identifier
          json.label step.label
          # json.description step.description
#           json.legislature_identifier step.legislature_identifier
#           json.legislature_label step.legislature_label
#           json.commons_identifier step.commons_identifier
#           json.lords_identifier step.lords_identifier
# 		  json.step_type_identifier step.step_type_identifier
		  json.step_type_label step.step_type_label
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
      json.identifier route.identifier     
#       json.start_on route.start_on     
#       json.end_on route.end_on     
#       json.from_step_identifier route.from_step_identifier     
      json.from_step_label route.from_step_label     
      json.from_step_type_identifier route.from_step_type_identifier     
      json.from_step_type_label route.from_step_type_label     
#       json.from_step_legislature_identifier route.from_step_legislature_identifier     
#       json.from_step_legislature_label route.from_step_legislature_label     
#       json.from_step_commons_identifier route.from_step_commons_identifier     
#       json.from_step_lords_identifier route.from_step_lords_identifier     
#       json.to_step_identifier route.to_step_identifier     
#       json.to_step_identifier route.to_step_identifier     
      json.to_step_label route.to_step_label     
      json.to_step_type_identifier route.to_step_type_identifier     
      json.to_step_type_label route.to_step_type_label     
#       json.to_step_legislature_identifier route.to_step_legislature_identifier     
#       json.to_step_legislature_label route.to_step_legislature_label     
#       json.to_step_commons_identifier route.to_step_commons_identifier     
#       json.to_step_lords_identifier route.to_step_lords_identifier     
    end
  end
end


