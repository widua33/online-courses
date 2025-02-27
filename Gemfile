source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8', '>= 7.0.8.4'

# Use postgres as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.8'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

# Generate beautiful API documentation, including a UI to explore and test operations,
# directly from your rspec integration tests. OpenAPI 2 and 3 supported.
gem 'multi_json', '~> 1.15'
gem 'rswag', '~> 2.15'

# Faster JSON serializers for Ruby, built on top of the powerful oj library.
gem 'oj_serializers', '~> 2.0', '>= 2.0.3'

# Common monads for Ruby
gem 'dry-monads', '~> 1.6'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Factory_bot provides a framework and DSL for defining and using factories - less error-prone, more explicit,
  # and all-around easier to work with than fixtures.
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'

  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '~> 3.4', '>= 3.4.2'

  # BDD for Ruby. RSpec runner and example groups.
  gem 'rspec-rails', '~> 7.0.0'

  # Simplify API integration testing with a succinct rspec DSL and generate OpenAPI specification files
  # directly from your rspec tests.
  gem 'rswag-specs', '~> 2.15'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Strategies for cleaning databases using ActiveRecord. Can be used to ensure a clean state for testing.
  gem 'database_cleaner-active_record', '~> 2.2'
end
