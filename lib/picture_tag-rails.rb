require "picture_tag-rails/version"
require 'picture_tag-rails/railtie'

def configure
  self.configuration = Configuration.new
  yield(configuration)
end
