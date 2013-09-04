require 'pathname'

Gem::Specification.new do |s|
  s.name        = "boundy"
  s.version     = "0.0.1"
  s.summary     = "A date bounding library"

  s.license     = "Proprietary"

  s.authors     = ["Ed Carrel"]
  s.email       = ["ed@pocketchange.com"]
  

  s.files       = Pathname.glob('lib/**/*.rb').map(&:to_path)
  s.files       += Pathname.glob('test/**/*.rb').map(&:to_path)

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'newrelic_rpm'

  s.add_development_dependency 'mocha' 
  s.add_development_dependency 'simplecov'
end

