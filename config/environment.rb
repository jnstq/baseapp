# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'rspec-rails', :lib => 'spec'
  
  config.action_controller.session = {
    :session_key => '_base_session',
    :secret      => '7389ea9180b15f1495a5e73a69a893311f859ccff1ffd0fa2d7ea25fdf1fa324f280e6ba06e3e5ba612e71298d8fbe7f15fd7da2929c45a9c87fe226d2f77347'
  }

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  config.active_record.observers = :user_observer
end

I18n.default_locale = 'en-US'
LOCALES_DIRECTORY = "#{Rails.root}/config/locales/"
LOCALES_AVAILABLE = Dir["#{LOCALES_DIRECTORY}/*.{rb,yml}"].collect do |locale_file|
  File.basename(File.basename(locale_file, ".rb"), ".yml")
end.uniq.sort