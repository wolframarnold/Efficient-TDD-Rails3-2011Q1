source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '~> 1.3.3'
gem 'omniauth', '~> 0.2.1'
gem 'haml', '~> 3.0.25'

gem 'spectator-validates_email', :require => 'validates_email'

gem 'simple_form'

gem 'simple-rss'

gem 'devise', '~> 1.2.1'

gem 'mongrel'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rspec-rails', '~> 2.5.0'
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'webrat', '>=0.7.2.beta.6', :git => 'git://github.com/orangewise/webrat'
end

group :test do
  gem 'factory_girl_rails'
  gem 'launchy' # for opening error pages from webrat & capybara in a browser
  gem 'fakeweb'
end
