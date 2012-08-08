source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.0.2'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Deploy with Capistrano
gem 'capistrano', '~> 2.12.0'

gem 'debugger', '~> 1.1.1'

# RSpec
group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails'
	gem "factory_girl_rails", "~> 3.0"
end

group :production do
	gem 'mysql2'
end

# scrapping 
gem "mechanize", '~> 2.4'
gem "hpricot", '~> 0.8.6'
gem "unf_ext", '~> 0.0.4'

# oauth
gem 'devise', '~> 2.0.4'
gem 'omniauth-facebook', '~> 1.2.0'
gem 'omniauth-openid', '~> 1.0.1'
gem 'omniauth-twitter', '~> 0.0.10'
gem 'bootstrap-sass', '>= 2.0.4.0'
