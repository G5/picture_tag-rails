$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
gem 'actionpack', '>= 3.0.0'
gem 'activesupport', '>= 3.0.0'
gem 'activemodel', '>= 3.0.0'
gem 'railties', '>= 3.0.0'

# Only the parts of rails we want to use
# if you want everything, use "rails/all"
require "action_controller/railtie"
require "rails/test_unit/railtie"

root = File.expand_path(File.dirname(__FILE__))

# Define the application and configuration
module Config
  class Application < ::Rails::Application
    config.assets.enabled = true
    config.assets.version = '1.1'
    config.active_support.deprecation = :stderr 
  end
end

# Initialize the application
Config::Application.initialize!

require 'rspec/rails'

RSpec.configure do |config|
end

require 'responsive_picture'
