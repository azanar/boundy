module Boundy
  class Time
    module Bound
      class Aligned
        class Beginning < Aligned
          def initialize(date)
            if date.nil?
              raise
            end
            @date = date.beginning_of_day
          end

          def align
          end
        end

        class End < Aligned
          def initialize(date)
            if date.nil?
              raise
            end
            @date = date.end_of_day
          end

          def align
          end
        end
      end
    end
  end
end
