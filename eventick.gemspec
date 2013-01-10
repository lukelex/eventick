# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'eventick/version'

Gem::Specification.new do |gem|
  gem.name          = "eventick"
  gem.version       = Eventick::VERSION
  gem.authors       = ["Lukas Alexandre"]
  gem.email         = ["lukasalexandre@me.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'json'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'guard-minitest'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'fakeweb'
end
