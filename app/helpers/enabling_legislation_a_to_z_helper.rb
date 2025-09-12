module EnablingLegislationAToZHelper

  def a_to_z_letter_link(letter, selected_letter)
    letter_downcase = letter.letter.downcase
    css_class = letter_downcase == selected_letter ? 'selected-letter' : ''

    link_to(letter.letter, enabling_legislation_atoz_show_url(letter: letter_downcase), class: css_class)
  end

  def all_letter_link
    css_class = on_all_page? ? 'selected-letter' : ''
    link_to('All', enabling_legislation_list_url, class: css_class)
  end

  def on_all_page?
    request.original_url == enabling_legislation_list_url
  end
end
