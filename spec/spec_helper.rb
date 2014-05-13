require 'rubygems'

require "action_controller/railtie"

module RbConfig
  class Application < ::Rails::Application
    config.active_support.deprecation = :stderr
  end
end
RbConfig::Application.initialize!

require 'rspec/rails'
require 'picture_tag-rails'
