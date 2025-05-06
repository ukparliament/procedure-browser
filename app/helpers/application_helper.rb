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
  
  def list_item_count_sentence_with_actualisation( first_type_of_thing, first_number_of_things, second_type_of_thing, second_number_of_things  )
    list_item_count_sentence = 'There '
    if first_number_of_things == 1
      list_item_count_sentence += 'is '
    else
      list_item_count_sentence += 'are '
    end
    list_item_count_sentence += ActiveSupport::NumberHelper.number_to_delimited( first_number_of_things )
    list_item_count_sentence += ' '
    list_item_count_sentence += first_type_of_thing.pluralize( first_number_of_things )
    list_item_count_sentence += ' actualising '
    list_item_count_sentence += ActiveSupport::NumberHelper.number_to_delimited( second_number_of_things )
    list_item_count_sentence += ' '
    list_item_count_sentence += second_type_of_thing.pluralize( second_number_of_things )
    list_item_count_sentence += '.'
    list_item_count_sentence = content_tag( 'p', list_item_count_sentence )
  end
  
  def class_display_label( object )
    class_display_label = ''
    words = object.class.name.split /(?=[A-Z])/
    words.each do |word|
      word.downcase! if word != words[0]
      class_display_label += word
      class_display_label += ' ' unless word == words.last
    end
    class_display_label.sub!( 'parliament', 'Parliament' )
    class_display_label
  end
end
