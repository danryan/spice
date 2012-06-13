source "http://rubygems.org"

gemspec

group :test do
  gem 'rake'
end

group :doc do
  gem 'yard'
  gem 'redcarpet'
end

group :local do
  gem 'guard', '>= 1.0.1'
  gem 'guard-rspec', '>= 0.6.0'
  gem 'guard-spork', '>= 0.5.2'
  gem 'rb-fsevent', '>= 0.9.0'
  gem 'growl', '>= 1.0.3'
  gem 'simplecov'
end

# JSON
# gem 'json', :platform => :jruby
gem 'yajl-ruby', :platform => [ :ruby_18, :ruby_19 ]

# OpenSSL
gem 'jruby-openssl', :platform => :jruby
