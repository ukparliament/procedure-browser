class LegislatureController < ApplicationController

  def show
    @page_title = 'Coming soon'
    render :template => 'under_construction/notice'
  end
end
