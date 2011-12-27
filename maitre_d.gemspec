# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "maitre_d/version"

Gem::Specification.new do |s|
  s.name        = 'maitre_d'
  s.version     = MaitreD::VERSION
  s.authors     = ['Pat Allan']
  s.email       = ['pat@freelancing-gods.com']
  s.homepage    = 'http://github.com/flying-sphinx/maitre_d'
  s.summary     = 'Rack API and Rails Engine for Heroku and Opperator add-ons'
  s.description = 'A Rack API (through Grape) for Heroku and Opperator add-on providers - which can also be attached as a Rails Engine.'

  s.rubyforge_project = "maitre_d"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rails',       '3.1.3'
  s.add_development_dependency 'rspec-rails', '2.7.0'
end
