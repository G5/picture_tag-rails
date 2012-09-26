require 'picture_tag-rails/view_helpers'
module PictureTag
  class Railtie < Rails::Railtie
    initializer "picture_tag.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end