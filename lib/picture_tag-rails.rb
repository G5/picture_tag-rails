require "picture_tag-rails/version"
require 'picture_tag-rails/railtie'

require_relative "./picture_tag-rails/configuration"

module PictureTag
  class << self
    attr_accessor :configuration

    def ininitlaize
      self.class.configure
    end

      # Pattern inspired by http://robots.thoughtbot.com/mygem-configure-block/
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
