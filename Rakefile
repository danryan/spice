require 'bundler/gem_tasks'

require 'rspec/core/rake_task'

task :default => :spec
desc "Run specs"
RSpec::Core::RakeTask.new do |task|
  task.pattern = "spec/**/*_spec.rb"
end
  
desc "Run guard"
task :guard do
  sh %{bundle exec guard start}
end

desc "Run spork"
task :spork do
  sh %{bundle exec spork}
end


Bundler.require(:doc)
desc "Generate documentation"
YARD::Rake::YardocTask.new do |t|
  t.files = [ 'lib/**/*.rb' ]
end