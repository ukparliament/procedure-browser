module ApplicationHelper
  
  def list_item_count_sentence( type_of_thing, number_of_things )
    list_item_count_sentence = 'There '
    if number_of_things == 1
      list_item_count_sentence += 'is '
    else
      list_item_count_sentence += 'are '
    end
    list_item_count_sentence += ActiveSupport::NumberHelper.number_to_delimited( number_of_things )
    list_item_count_sentence += ' '
    list_item_count_sentence += type_of_thing.pluralize( number_of_things ) 
    list_item_count_sentence += '.'
    list_item_count_sentence = content_tag( 'p', list_item_count_sentence )
  end
end
