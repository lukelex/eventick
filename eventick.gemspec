# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'eventick/version'

Gem::Specification.new do |gem|
  gem.name          = "eventick_api"
  gem.version       = Eventick::VERSION
  gem.authors       = ["Lukas Alexandre", "Thiago Diniz"]
  gem.email         = ["lukasalexandre@me.com", "thiago@eventick.com.br"]
  gem.description   = %q{Eventick is a simple API wrapper for Eventick's public API.}
  gem.summary       = %q{Eventick is a simple API wrapper for Eventick's public API.}
  gem.homepage      = ""
  gem.license = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'json'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'guard-minitest'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'fakeweb'
end
