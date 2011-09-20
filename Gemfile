source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'jquery-rails', '1.0.13'
gem 'will_paginate', '3.0.0'
gem 'fog', '0.11.0'
gem 'rmagick', '2.13.1'
gem 'carrierwave', '0.5.7'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier', '1.0.2'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3', '1.3.4'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec-rails', '2.6.1'
  gem 'guard', :git => 'git://github.com/guard/guard.git'
  gem 'guard-rspec', '0.4.3'
  gem 'guard-annotate', '0.4.0'
  gem 'rb-fsevent', '0.4.3.1'
  gem 'growl_notify', '0.0.1'
  gem 'powder', '0.1.6'
  gem 'fuubar', '0.0.6'
  gem 'faker', '0.9.5'
end

group :test do
  gem 'rspec-rails', "2.6.1"
  gem 'webrat', '0.7.3'
  gem 'factory_girl_rails', '1.2.0'
  gem 'simplecov', '>= 0.4.0', :require => false
end
