# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spice/version"

Gem::Specification.new do |s|
  s.name        = "spice"
  s.version     = Spice::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dan Ryan"]
  s.email       = ["hi@iamdanryan.com"]
  s.homepage    = "http://github.com/danryan/spice"
  s.summary     = %q{Chef API wrapper}
  s.description = %q{A zesty Chef API wrapper}

  s.rubyforge_project = "spice"
  
  s.add_dependency "rest-client"
  s.add_dependency "mixlib-authentication"
  s.add_dependency "yajl-ruby"
  
  s.add_development_dependency "yard", "~> 0.6.4"
  s.add_development_dependency "rspec", "~> 2.4.0"
  s.add_development_dependency "cucumber", "~> 0.10.0"
  s.add_development_dependency "webmock", "~> 1.6.1"
  s.add_development_dependency "vcr", "~> 1.4.0"
  s.add_development_dependency "timecop", "~> 0.3.5"
  s.add_development_dependency "forgery", "~> 0.3.6"
  s.add_development_dependency "chef", "0.9.12"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
