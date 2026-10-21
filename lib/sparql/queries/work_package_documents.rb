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
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the relevant properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
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

    # We find all work packaged things that have a work package and a name.
    ?paper a :WorkPackagedThing ;
           :name ?paperName ;
           :workPackagedThingHasWorkPackage ?workPackage .

    # We filter the work package to only include the one specified by the work_package_id parameter.
    FILTER (?workPackage IN (id:#{work_package_id}))

    # We find all business items that are in the work package and have a link and a procedure step.
    ?workPackage :workPackageHasBusinessItem ?businessItem .

    ?businessItem
    :businessItemHasBusinessItemWebLink ?businessItemLink ;
    :businessItemHasProcedureStep ?businessItemProcedureStep .

    # We find the date of the business item, if it has one.
    # Note that some business items do not have a date, so we use OPTIONAL to avoid filtering them out.
    OPTIONAL {
        ?businessItem :businessItemDate ?businessItemDate .
    }

    # We look for the procedure step that is in the documents collection, which has the ID Ji8bWVUj.
    ?businessItemProcedureStep
    :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection
    id:Ji8bWVUj .

    # We find the name of the procedure step.
    ?businessItemProcedureStep
    :name ?businessItemProcedureStepName .

    # We check to see if the step belongs to a legislature.
    # A legislature will be Scottish Parliament, Senedd Cymru or the Northern Ireland Assembly.
    OPTIONAL {
        ?businessItemProcedureStep
        :procedureStepInLegislature ?legislature .
        ?legislature :name ?legislatureName .
    }

    # We check to see if the step belongs to the House of Commons.
    OPTIONAL {
        ?businessItemProcedureStep
        :procedureStepHasHouse ?commonsId .
        FILTER ( ?commonsId = id:1AFu55Hs )
    }

    # We check to see if the step belongs to the House of Lords.
    OPTIONAL {
        ?businessItemProcedureStep
        :procedureStepHasHouse ?lordsId .
        FILTER ( ?lordsId = id:WkUWUBMx )
    }

    # We find the document type collection that the business item's procedure step is in.
    ?businessItemProcedureStep
    :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection ?documentTypeCollection .

    # We filter the document type collection to only include the ones specified in the VALUES clause below.
    VALUES ?documentTypeCollection {
        id:YeyqTPT6
        id:yuLI4KIY
        id:GJyoVAV5
        id:SHG1bKCe
        id:ZimrKJ0K
        id:KMGLDo11
        id:pOJcdzzC
        id:z50GS6Tf
        id:QRSSCXah
        id:oIM2ytjh
    }

    # We find the name of the document type collection.
    ?documentTypeCollection
    :name ?documentTypeCollectionName .

}

# We order the results by the date of the business item, so that the most recent business items appear first.
ORDER BY ?businessItemDate
      "
    ]
  end
end