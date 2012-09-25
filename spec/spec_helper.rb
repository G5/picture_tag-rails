require 'rubygems'

require "action_controller/railtie"

module Config
  class Application < ::Rails::Application
    config.active_support.deprecation = :stderr 
  end
end
Config::Application.initialize!

require 'rspec/rails'
require 'picture_tag'
