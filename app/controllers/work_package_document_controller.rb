class WorkPackageDocumentController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageDocuments
  include Sparql::Queries::WorkPackageDocuments
  include Sparql::Get::Response
  include Timeline::Timeline

  def index
    work_package_id = params[:work_package]
  
    # We get the work package.
    @work_package = get_work_package( work_package_id )
    
    # We get the business items being the reading list for the work package.
    @documents = get_work_package_documents( work_package_id )
    
    # We check the format we're expected to respond with.
    respond_to do |format|
    
      # If we're expected to respond with RSS ...
      format.rss {
      
        # ... we reverse the documents array to list reverse chronologically.
        @documents.reverse!
      }
      
      # If we're expected to respond with HTML ...
      format.html {
      
        # We create a set of arrays to hold the documents by their type.
        @committee_correspondence_documents = []
        @government_response_to_select_commmittee_documents = []
        @ministerial_statement_documents = []
        @committee_oral_evidence_session_documents = []
        @associated_paper_documents = []
        @debate_documents = []
        @committee_concerns_documents = []
        @upgrade_to_affirmative_documents = []
        
        # For each document ...
        @documents.each do |document|
        
          # ... if the document is committee correspondence ....
          if document.is_committee_correspondence
          
            # ... we add the document to the committee correspondences array.
            @committee_correspondence_documents << document
            
          # Otherwise, if the document is a government response to a select committee report ...
          elsif document.is_government_response_to_select_commmittee_report
          
            # ... we add the document to the government response to select committee array.
            @government_response_to_select_commmittee_documents << document
          
          # Otherwise, if the document is a ministerial statement ...
          elsif document.is_ministerial_statement
          
            # ... we add the document to the ministerial statement array.
            @ministerial_statement_documents << document
          
          # Otherwise, if the document is a committee oral evidence statement ...
          elsif document.is_committee_oral_evidence_session
          
            # ... we add the document to the committee oral evidence array.
            @committee_oral_evidence_session_documents << document
          
          # Otherwise, if the document is an associated paper ...
          elsif document.is_associated_paper
          
            # ... we add the document to the associated paper array.
            @associated_paper_documents << document
          
          # Otherwise, if the document is a debate ...
          elsif document.is_debate
          
            # ... we add the document to the debate array.
            @debate_documents << document
          
          # Otherwise, if the document is a committee concern ...
          elsif document.is_committee_concerns
          
            # ... we add the document to the committee concern array.
            @committee_concerns_documents << document
          
          # Otherwise, if the document is an upgrade to affirmative ...
          elsif document.is_upgrade_to_affirmative
          
            # ... we add the document to the upgrade to affirmative array.
            @upgrade_to_affirmative_documents << document
          end
        end
        
        # ... we set the page meta information.
        @page_title = "Documents for #{@work_package.work_packageable_thing_label}"
        @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Documents</span>".html_safe
        @description = "Documents for #{@work_package.work_packageable_thing_label}."
        @rss_url = work_package_document_list_url( :format => 'rss' )
        @crumb << { label: 'Work packages', url: work_package_list_url }
        @crumb << { label: @work_package.work_packageable_thing_label, url: work_package_show_url }
        @crumb << { label: 'Documents', url: nil }
        @section = 'work-packages'
        @subsection = 'documents'
      }
    end
  end
end
