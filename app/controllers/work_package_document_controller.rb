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

    @page_title = "Documents for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Documents</span>".html_safe
    @description = "Documents for #{@work_package.work_packageable_thing_label}."
    @rss_url = work_package_document_list_url( :format => 'rss' )
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @work_package.work_packageable_thing_label, url: work_package_show_url }
    @crumb << { label: 'Documents', url: nil }
    @section = 'work-packages'
    @subsection = 'documents'
  end
end
