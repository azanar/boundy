require 'boundy/comparator'

module Boundy
  module Domain
    class Comparator
      include Boundy::Comparator

      def initialize(datum, subject)
        @datum = datum
        @subject = subject
      end

      def after?
        @subject.from > @datum && @subject.to >= @datum
      end 

      def before?
        @subject.from <= @datum && @subject.to < @datum
      end 

      def within?
        @subject.from <= @datum && @subject.to >= @datum
      end 
    end
  end
end
