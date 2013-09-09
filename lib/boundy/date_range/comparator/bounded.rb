module Boundy
  module DateRange
    module Comparator
      class Bounded
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
end
