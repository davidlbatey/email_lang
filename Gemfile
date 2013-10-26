source 'https://rubygems.org'

gem 'rails', '4.0.0'

# frontend
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'draper'
gem 'haml'

# javascript
gem 'jquery-rails'

# stylesheets
gem 'compass-rails'

# databases
gem 'mysql2'

# security
gem "devise", "~> 3.0.1"

group :development do
  gem 'haml-rails'
  gem 'rspec-rails', '>= 2.10.1'

  gem "quiet_assets"
  gem "awesome_print"
  gem "interactive_editor"
end

group :development, :test do
  gem 'debugger'
end

group :test do
  gem 'sqlite3'
end

group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'rack-google-analytics', :require => 'rack/google-analytics'
end

gem 'unicorn'
