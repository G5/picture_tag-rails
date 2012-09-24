require 'responsive_picture/view_helpers'
module ResponsivePicture
  class Railtie < Rails::Railtie
    initializer "responsive_picture.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end