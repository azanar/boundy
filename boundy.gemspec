require 'pathname'

Gem::Specification.new do |s|
  s.name        = "boundy"
  s.version     = "0.3.0"
  s.summary     = "A ranging and constraining gem"
  s.description = <<-EOF
  Boundy is a bounding and constraining library for any comparable types; it is like Ranges, but with much more flexibility.

  Boundy allows for the creation of bounded and partially-bounded intervals -- or domains. Boundy allows for these domains to be intersected, creating a new domain, which can be acted on further.

  I originally wrote Boundy for intersecting date ranges for reporting, but it should be useable for any Comparable types.
  EOF

  s.license     = "MIT"

  s.authors     = ["Ed Carrel"]
  s.email       = ["edward@carrel.org"]
  

  s.files       = Pathname.glob('lib/**/*.rb').map(&:to_path)
  s.files       += Pathname.glob('test/**/*.rb').map(&:to_path)

  s.add_runtime_dependency 'punchout'

  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'mocha' 
  s.add_development_dependency 'simplecov'
end

