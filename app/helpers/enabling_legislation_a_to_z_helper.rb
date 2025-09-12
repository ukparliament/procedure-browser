module EnablingLegislationAToZHelper

  def a_to_z_letter_link(letter, selected_letter)
    letter_downcase = letter.letter.downcase

    if letter_downcase == selected_letter
      link_to(letter.letter, enabling_legislation_atoz_show_url(letter: letter_downcase), class: 'selected-letter')
    else
      link_to(letter.letter, enabling_legislation_atoz_show_url(letter: letter_downcase))
    end
  end

  def all_letter_link
    if on_all_page?
      link_to('All', enabling_legislation_list_url, class: 'selected-letter')
    else
      link_to('All', enabling_legislation_list_url)
    end
  end

  def on_all_page?
    request.original_url == enabling_legislation_list_url
  end
end
