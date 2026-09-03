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
      
        # ... we create a new work package document list ...
        @work_package_document_list = WorkPackageDocumentList.new
        
        # ... containing an array of collections.
        @work_package_document_list.work_package_document_collections = []
      
        # For each document ...
        @documents.each do |document|
        
          #  ... if the document has a type label ...
          if document.document_type_label
        
            # .. if the work package document collections array contains a collection for this document type ...
            if @work_package_document_list.work_package_document_collections.any?{ |work_package_document_collection| work_package_document_collection.label == document.document_type_label }
          
              # ... we get the work package document collection for this document type ...
              work_package_document_collection = @work_package_document_list.work_package_document_collections.select{ |work_package_document_collection| work_package_document_collection.label == document.document_type_label }.first
            
              # ... and add this document to the collection.
              work_package_document_collection.documents << document
          
            # Otherwise, if the work package document collections array does not contain a collection for this document type ...
            else
          
              # ... we create a new work package document collection ...
              work_package_document_collection = WorkPackageDocumentCollection.new
            
              # ... with the label of this document type ...
              work_package_document_collection.label = document.document_type_label
            
              # ... including this document ...
              work_package_document_collection.documents = [document]
            
              # ... and adding it to the work package document list.
              @work_package_document_list.work_package_document_collections << work_package_document_collection
            end
          end
        end
        
        # We sort the work package document collections array by the labels of the collections.
        @work_package_document_list.work_package_document_collections.sort_by!( &:label )
        
        # We set the page meta information.
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
