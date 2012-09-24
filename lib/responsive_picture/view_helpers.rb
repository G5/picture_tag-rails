module ResponsivePicture
  module ViewHelpers
    def picture_tag(image_path, options={})
      filename, extension = split_image_path(image_path)
      sizes = options.delete(:sizes) || default_sizes
      html = "<picture>"
    
      sizes.each do |size, media_query| 
        html << create_source(filename, size, extension, media_query)
      end
      html << add_default_source_and_image(filename, sizes.keys.last, extension, options)
    
      html << "</picture>"
      html
    end
  
    def split_image_path(image_path)
      image_path.gsub!('-original', '')
      image_path.split(/\.(?=[^\.]+(?: |$))| /)
    end
  
    def create_source(filename, size, extension, media_query=nil)
      srcset = image_path("#{filename}-#{size}.#{extension}") + " 1x, "
      srcset << image_path("#{filename}-#{size}@2x.#{extension}") + " 2x"
      "<source #{"media='#{media_query}' " if media_query}srcset='#{srcset}' />"
    end
  
    def add_default_source_and_image(filename, size, extension, options)
      html = create_source(filename, size, extension)    
      options[:alt] ||= filename.split('/').last.capitalize
      html << image_tag("#{filename}-#{size}.#{extension}", options)
      html
    end
  
    def default_sizes
      {
        large:  "(min-width: 1600px)", 
        medium: "(min-width: 1000px)", 
        small:  "(min-width: 768px)", 
        tiny:   "(min-width: 480px)"
      }
    end
  
  end
end