require 'bundler/gem_tasks'

require 'rspec/core/rake_task'

# task :default => :spec
# desc "Run specs"
# RSpec::Core::RakeTask.new do |task|
#   task.pattern = "spec/**/*_spec.rb"
# end

desc "Run specs"
RSpec::Core::RakeTask.new(:spec) {|t|}

namespace :spec do
  desc "Clean up rbx compiled files and run spec suite"
  RSpec::Core::RakeTask.new(:ci) { |t| Dir.glob("**/*.rbc").each {|f| FileUtils.rm_f(f) } }
end

desc "Run guard"
task :guard do
  sh %{bundle exec guard start}
end

desc "Run spork"
task :spork do
  sh %{bundle exec spork}
end
