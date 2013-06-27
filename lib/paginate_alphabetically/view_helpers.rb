module PaginateAlphabetically
  module ViewHelpers
    def alphabetically_paginate(collection, options = {})
      if options[:always_display]
        available_letters = PaginateAlphabetically::ALL_LETTERS
      else
        return "" if collection.empty?
        available_letters = collection.first.class.pagination_letters
      end
      content_tag(:ul, safe(alphabetical_links_to(available_letters)),
                  :class => options[:class] || "pagination")
    end

    def safe(content)
      if content.respond_to?(:html_safe)
        return content.html_safe
      end
      content
    end

    def alphabetical_links_to(available_letters)
      ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','а','б','в','г','л','е','ж','з','и','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','э','ю','я'].map do |letter|
        content_tag(:li, paginated_letter(available_letters, letter))
      end.join(" ")
    end

    def paginated_letter(available_letters, letter)
      if available_letters.include?(letter)
        link_to(letter, "#{request.path}?letter=#{letter}")
      else
        letter
      end
    end
  end
end
