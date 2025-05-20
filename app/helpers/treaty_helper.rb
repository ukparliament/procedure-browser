module TreatyHelper

  def treaty_series_citation( treaty )
    citation = ''
    if treaty.country_series_membership_citation
      citation += treaty.country_series_membership_citation
      citation += ', in the Country Series.'
    end
    if treaty.european_union_series_membership
      citation += treaty.european_union_series_membership_citation
      citation += ', in the European Union Series.'
    end
    if treaty.miscellaneous_series_membership
      citation += treaty.miscellaneous_series_membership_citation
      citation += ', in the Miscellaneous Series.'
    end
    content_tag( 'p', citation )
  end
end
