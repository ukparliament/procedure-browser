class MetaController < ApplicationController

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
end
