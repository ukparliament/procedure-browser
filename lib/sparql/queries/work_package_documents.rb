module Sparql::Queries::WorkPackageDocuments

  # A SPARQL query to get all business items in a work package with a link, actualising steps in the reading list collection.
  def work_package_documents_query( work_package_id )
    [
  
      # The title of the SPARQL query.
      'A list of business items in a work package with a link, actualising steps in the reading list collection',
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/60f67898',
    
      # The SPARQL query.
      "
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

SELECT
    ?paper
    ?paperName
    ?workPackage
    ?businessItem
    ?businessItemLink
    ?businessItemProcedureStep
    ?businessItemDate
    ?businessItemProcedureStepName
    ?legislature
    ?legislatureName
    ?commonsId
    ?lordsId
    ?documentTypeCollection
    ?documentTypeCollectionName

WHERE {

    ?paper a :WorkPackagedThing ;
           :name ?paperName ;
           :workPackagedThingHasWorkPackage ?workPackage .

    FILTER (?workPackage IN (id:#{work_package_id}))

    ?workPackage :workPackageHasBusinessItem ?businessItem .

    ?businessItem
        :businessItemHasBusinessItemWebLink ?businessItemLink ;
        :businessItemHasProcedureStep ?businessItemProcedureStep .

    OPTIONAL {
        ?businessItem :businessItemDate ?businessItemDate .
    }

    ?businessItemProcedureStep
        :procedureStepHasProcedureStepCollectionMembership/
        :procedureStepCollectionMembershipHasProcedureStepCollection
        id:Ji8bWVUj .

    ?businessItemProcedureStep
        :name ?businessItemProcedureStepName .

    OPTIONAL {
        ?businessItemProcedureStep
            :procedureStepInLegislature ?legislature .

        ?legislature :name ?legislatureName .
    }

    OPTIONAL {
        ?businessItemProcedureStep
            :procedureStepHasHouse ?commonsId .

        FILTER (?commonsId = id:1AFu55Hs)
    }

    OPTIONAL {
        ?businessItemProcedureStep
            :procedureStepHasHouse ?lordsId .

        FILTER (?lordsId = id:WkUWUBMx)
    }


        ?businessItemProcedureStep
            :procedureStepHasProcedureStepCollectionMembership/
            :procedureStepCollectionMembershipHasProcedureStepCollection
            ?documentTypeCollection .

        VALUES ?documentTypeCollection {
            id:YeyqTPT6
            id:yuLI4KIY
            id:GJyoVAV5
            id:SHG1bKCe
            id:ZimrKJ0K
            id:KMGLDo11
            id:7CBVQcZF
            id:m7fzgEd2
        }

        ?documentTypeCollection
            :name ?documentTypeCollectionName .


}

ORDER BY ?businessItemDate
      "
    ]
  end
end