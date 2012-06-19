# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spice/version"

Gem::Specification.new do |s|
  s.name        = "spice"
  s.version     = Spice::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ "Dan Ryan" ]
  s.email       = [ "hi@iamdanryan.com" ]
  s.homepage    = "https://github.com/danryan/spice"
  s.summary     = %q{Chef API wrapper}
  s.description = %q{Spice is a zesty Chef API wrapper. Its primary purpose is to let you easily integrate your apps with a Chef server easily.  Spice provides support for the entire released Chef API}
  s.license     = "MIT"

  s.rubyforge_project = "spice"
  s.add_dependency "faraday", "~> 0.8.0"
  s.add_dependency "mixlib-authentication", '>= 1.1.4'
  s.add_dependency "multi_json", '~> 1.3.6'
  
  s.add_development_dependency 'rspec', '>= 2.8.0'
  s.add_development_dependency "webmock", ">= 1.8.2"
  s.add_development_dependency "timecop", ">= 0.3.5"
  s.add_development_dependency 'spork', '>= 1.0.0.rc2'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
