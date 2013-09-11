module Boundy
  class Domain
    class Comparator
      def initialize(date, subject)
        @date = date
        @subject = subject
      end

      def after?
        @subject.from > @date && @subject.to >= @date
      end 

      def before?
        @subject.from <= @date && @subject.to < @date
      end 

      def within?
        @subject.from <= @date && @subject.to >= @date
      end 
    end
  end
end
