module Boundy
  module Domain
    module Builder
    def self.builders
      [
        {
          bounds: {
            from: Boundy::Bound::Infinite::Below, 
            to: Boundy::Bound
          },
          builder: Proc.new {|b,e| Boundy::Domain::Anterior.new(e) }
        },
        {
          bounds: {
            from: Boundy::Bound, 
            to: Boundy::Bound
          },
          builder: Proc.new {|b,e| Boundy::Domain::Finite.new(b,e) }
        },
        {
          bounds: {
            from: Boundy::Bound, 
            to: Boundy::Bound::Infinite::Above
          },
          builder: Proc.new {|b,e| Boundy::Domain::Posterior.new(b) }
        }
      ]
    end
    end
  end
end
