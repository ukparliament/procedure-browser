class WorkPackageReadingListController < ApplicationController


  def index
    redirect_to( work_package_document_list_url, :status => :moved_permanently )
  end
end
