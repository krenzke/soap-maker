source "https://rubygems.org"

gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
# gem "importmap-rails"
gem 'tailwindcss-rails'
gem 'vite_rails'
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "fabrication"
gem "ffaker"
gem "kaminari"
gem "image_processing", ">= 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
end

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [ :ruby ]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
