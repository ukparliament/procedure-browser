class MetaController < ApplicationController

  # We include modules required to get all procedures and a procedure.
  include Sparql::Get::Procedures
  include Sparql::Queries::Procedures
  include Sparql::Get::Response

  def index
    @page_title = 'Meta'
    @description = 'Meta.'
    @crumb << { label: 'Meta', url: nil }
  end

  def sitemap
    @page_title = 'Sitemap'
    @description = 'Sitemap.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Sitemap', url: nil }
  end

  def cookies
    @page_title = 'Cookies'
    @description = 'Cookie policy.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Cookies', url: nil }
    
    render 'library_design/meta/cookies'
  end

  def bookmarklets
    @page_title = 'Bookmarklets'
    @description = 'Bookmarklets.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Bookmarklets', url: nil }
  end

  def librarian_tools
    @page_title = 'Librarian tools'
    @description = 'Librarian tools.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: nil }
  end

  def maps
    @procedures = get_procedures
    
    @page_title = 'Procedure maps'
    @description = 'Procedure maps.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Procedure maps', url: nil }
  end

  def useful_queries
    @page_title = 'Librarian tools - useful queries'
    @multiline_page_title = "Librarian tools <span class='subhead'>Useful queries</span>".html_safe
    @description = 'Librarian tools - useful queries.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'Useful queries', url: nil }
  end

  def librarian_mode_styles
    @page_title = 'Librarian tools - librarian mode styles'
    @multiline_page_title = "Librarian tools <span class='subhead'>Librarian mode styles</span>".html_safe
    @description = 'Librarian tools - librarian mode styles.'
    @crumb << { label: 'Meta', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'Librarian mode styles', url: nil }
  end
end
