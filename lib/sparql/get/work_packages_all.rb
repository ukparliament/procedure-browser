module Sparql::Get::WorkPackagesAll

  # A method to get an array of all work packages.
  def get_work_packages_all

    # We get the all work packages query.
    request_body = work_packages_all_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      work_package.identifier = row['workPackage']
      work_package.work_packageable_thing_identifer = row['Paper']
      work_package.work_packageable_thing_label = row['Papername']
      work_package.making_available_identifier = row['businessItem']
      work_package.made_available_on = row['combinedDate'].to_date if row['combinedDate']
      work_package.procedure_identifier = row['procedure']
      work_package.procedure_label = row['procedureName']
      work_package.calculation_style_identifier = row['calculationStyle']
      work_package.calculation_style_label = row['calculationStyleName']
      
      # If the query returns the committee concerns flag ...
      if row['hasCommitteeConcernsFlag']
      
        # ... if the committee concerns flag is 'true' ...
        if row['hasCommitteeConcernsFlag'] == 'true'
        
          # ... we set the committee concerns flag to true.
          work_package.has_committee_concerns = true
        
        # Otherwise, if the committee concerns flag is not 'true' ...
        else
        
          # ... we set the committee concerns flag to false.
          work_package.has_committee_concerns = false
        end
        
      # Otherwise, if the query does not return the committee concerns flag ...
      else
      
        # ... we set the committee concerns flag to nil.
        work_package.has_committee_concerns = nil
      end
      
      # If the query returns the motions tabled flag ...
      if row['hasMotionTabledFlag']
      
        # ... if the motions tabled flag is 'true' ...
        if row['hasMotionTabledFlag'] == 'true'
        
          # ... we set the motions tabled flag to true.
          work_package.has_motion_tabled = true
        
        # Otherwise, if the motions tabled flag is not 'true' ...
        else
        
          # ... we set the motions tabled flag to false.
          work_package.has_motion_tabled = false
        end
        
      # Otherwise, if the query does not return the motions tabled flag ...
      else
      
        # ... we set the motions tabled flag to nil.
        work_package.has_motion_tabled = nil
      end
      
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work packages.
    work_packages
  end
end