# frozen_string_literal: true

source 'https://rubygems.org'

gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 8.0.2'

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem 'solid_cable'
gem 'solid_cache'
gem 'solid_queue'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem 'thruster', require: false

gem 'rack-cors'

gem 'blueprinter', '~> 1.1', '>= 1.1.2'
gem 'subroutine', '~> 4.4'

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end
