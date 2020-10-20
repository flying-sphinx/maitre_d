# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'maitre_d'
  s.version     = '0.7.1'
  s.authors     = ['Pat Allan']
  s.email       = ['pat@freelancing-gods.com']
  s.homepage    = 'http://github.com/flying-sphinx/maitre_d'
  s.summary     = 'Rack APIs for Heroku add-ons'
  s.description = 'A Rack API (through Grape) for Heroku add-on providers.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'sliver',     '~> 0.2.2'
  s.add_runtime_dependency 'multi_json', '>= 1.3.0'

  s.add_development_dependency 'combustion',  '~> 1.3'
  s.add_development_dependency 'kensa',       '2.1.0'
  s.add_development_dependency 'rails',       '~> 6.0'
  s.add_development_dependency 'rspec-rails', '~> 4.0'
end
