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
  s.description = %q{Spice is a zesty Chef API wrapper. Its primary purpose is to let you easily integrate your apps with a Chef server easily.  Spice provides support for the entire released Chef API}

  s.rubyforge_project = "spice"
  
  s.add_dependency "virtus", ">= 0.3.0"
  s.add_dependency "aequitas", ">= 0.0.2"
  s.add_dependency "activemodel", ">= 3.2.2"
  s.add_dependency "faraday"
  s.add_dependency "mixlib-authentication", '>= 1.1.4'
  s.add_dependency "yajl-ruby", '>= 1.1.0'
  
  s.add_development_dependency 'rspec', '>= 2.6.0'
  s.add_development_dependency "webmock", ">= 1.6.2"
  s.add_development_dependency "timecop", ">= 0.3.5"
  s.add_development_dependency 'guard', '>= 0.6.2'
  s.add_development_dependency 'guard-rspec', '>= 0.4.2'
  s.add_development_dependency 'guard-spork', '>= 0.2.1'
  s.add_development_dependency 'spork', '>= 0.9.0.rc8'
  s.add_development_dependency 'rb-fsevent', '>= 0.4.3.1'
  s.add_development_dependency 'growl', '>= 1.0.3'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
