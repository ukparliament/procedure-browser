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
      
        # ... we create and populate a new work package document list.
        @work_package_document_list = create_and_populate_work_package_document_list( @documents )
        
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
  
private

  # A method to create and populate a work package document list.
  def create_and_populate_work_package_document_list( documents )
  
    # We create a new work package document list.
    work_package_document_list = WorkPackageDocumentList.new
  
    # For each document ...
    documents.each do |document|
  
      #  ... if the document has a type label ...
      if document.document_type_label
    
        # ... we attempt to find a collection for this document type in the document collections array.
        work_package_document_collection = work_package_document_list.work_package_document_collections.find{ |work_package_document_collection| work_package_document_collection.label == document.document_type_label }
      
        # If we fail to find a collection for this document type in the document collections array ...
        unless work_package_document_collection
    
          # ... we create a new work package document collection ...
          work_package_document_collection = WorkPackageDocumentCollection.new
      
          # ... with the label of this document type ...
          work_package_document_collection.label = document.document_type_label
      
          # ... and adding it to the work package document list.
          work_package_document_list.work_package_document_collections << work_package_document_collection
        end
        
        # ... we add this document to the collection.
        work_package_document_collection.documents << document
      end
    end
    
    # We sort the work package document collections array by the labels of the collections.
    work_package_document_list.work_package_document_collections.sort_by!( &:label )
    
    # We return the work package document list.
    work_package_document_list
  end
end
