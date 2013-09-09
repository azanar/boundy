require 'boundy/date_range/comparator/range'
require 'boundy/date_range/comparator/time'

module Boundy
  module DateRange
    class Bounded
      class Bound
        module DayAligned
          class Beginning < Bound
            def initialize(date)
              if date.nil?
                raise
              end
              @date = date.beginning_of_day
            end
          end

          class End < Bound
            def initialize(date)
              if date.nil?
                raise
              end
              @date = date.end_of_day
            end
          end
        end

        def initialize(date)
          if date.nil?
            raise "Date passed is nil!"
          end
          @date = date
        end

        def comparator(subject)
          case subject
          when Time
            Boundy::DateRange::Comparator::Time.new(@date, subject)
          when Range
            Boundy::DateRange::Comparator::Range.new(@date, subject)
          else
            raise "I can't compare myself to a #{subject.inspect}"
          end
        end

        def after?(subject)
          comparator(subject).after?
        end

        def before?(subject)
          comparator(subject).before?
        end

        def within?(subject)
          comparator(subject).within?
        end

        def in_time_zone(tz)
          self.class.new(@date.in_time_zone(tz))
        end

        def beginning_of_day
          DayAligned::Beginning.new(@date)
        end

        def end_of_day
          DayAligned::End.new(@date)
        end

        def utc
          self.class.new(@date.utc)
        end

        attr_reader :date

        include Comparable

        def <=>(other)
          case other
          when Bound::Infinite
            other <=> self
          when Bound
            date <=> other.date
          else
            raise "UGH!"
          end
        end

        def to_sql_timestamp
          @date.strftime("%Y-%m-%d %H:%M:%S")
        end
      end
    end
  end
end
