source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

########## GEMS BASE ##########
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
# gem "sassc-rails"
gem "image_processing", "~> 1.2"

########## GEMS PESONNEL ##########
gem "devise"
gem "acts_as_votable"
gem "acts_as_list"
gem "active_link_to"
gem "letter_opener"
gem "noticed"
gem "ransack", github: "activerecord-hackery/ransack", branch: "main"
gem "friendly_id", "~> 5.4", ">= 5.4.2"
gem "bullet"
gem "sass"
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "followability"
gem "chartkick", "~> 5.0", ">= 5.0.1"
gem "groupdate"
gem "prawn", "~> 2.4"
gem "simple_calendar", "~> 2.4"
gem "pagy", "~> 6.0", ">= 6.0.2"
gem "mini_magick"
gem "pundit"

########## GEMS DEVELOPMENT TEST ##########
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

########## GEMS DEVELOPMENT ##########
group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "web-console"
  gem "foreman", github: "ddollar/foreman"
  # gem "rack-mini-profiler"
  # gem "spring"
end

########## GEMS TEST ##########
group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
