# -*- encoding : utf-8 -*-
module PaginateAlphabetically
  ALL_LETTERS = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','а','б','в','г','л','е','ж','з','и','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','э','ю','я').to_a
  module ActiveRecord
    def paginate_alphabetically(params)
      @attribute = params[:by]
      @paginate_alphabetically__show_all_letters = params[:show_all_letters] || false
      self.extend ClassMethods
    end

    module ClassMethods
      def pagination_letters
        return ALL_LETTERS if @paginate_alphabetically__show_all_letters
        all.sort_by{|obj| obj.send(@attribute).upcase}.group_by {|group| group.send(@attribute)[0].chr.upcase}.keys
      end

      def first_letter
        first_instance = find(:first, :order => @attribute, :conditions => ["#{@attribute.to_s} >= ?", 'a'])
        return 'A' if first_instance.nil?
        first_instance.send(@attribute)[0].chr.upcase
      end

      def alphabetical_group(letter = nil)
        letter ||= first_letter
        where(["LOWER(#{@attribute.to_s}) LIKE ?", "#{letter.downcase}%"]).order(@attribute)
      end
    end
  end
end
