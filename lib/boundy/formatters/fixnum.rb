module Boundy
  module Formatters
    class Fixnum
      def initialize(num, name)
        @num = num
      end

      def self.type
        ::Fixnum
      end

      include Boundy::Formatters::Bound
      include Boundy::Formatter::Sql::Plugin

      def to_s
        @num
      end
    end
  end
end
