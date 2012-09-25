module PictureTag
  module ViewHelpers
    
    def picture_tag(image_path, options={})
      filename, extension = split_image_path_from_extension(image_path)
      sizes = determine_sizes(options)
      
      html = "<picture>"
      sizes.each do |size, media_query| 
        html << build_source_tag(filename, size, extension, media_query)
      end
      html << add_default_source_and_image(filename, sizes.last.first, extension, options)
      html << "</picture>"
      
      html
    end
  
    def split_image_path_from_extension(image_path)
      image_path.gsub!('-original', '')
      image_path.split(/\.(?=[^\.]+(?: |$))| /) # Splits on last period before the first whitespace.
    end
  
    def build_source_tag(filename, size, extension, media_query=nil)
      srcset = image_path("#{filename}-#{size}.#{extension}") + " 1x, "
      srcset << image_path("#{filename}-#{size}@2x.#{extension}") + " 2x"
      "<source #{"media='#{media_query}' " if media_query}srcset='#{srcset}' />"
    end
  
    def add_default_source_and_image(filename, size, extension, options)
      html = build_source_tag(filename, size, extension)    
      options[:alt] ||= filename.split('/').last.capitalize
      html << image_tag("#{filename}-#{size}.#{extension}", options)
      html
    end
    
    def determine_sizes(options)
      sizes = options.delete(:sizes) || default_sizes
      max_width = options[:max_width].to_i if options[:max_width]
      sizes = sizes.delete_if {|k,query| query.match(/\d+/)[0].to_i > max_width } if max_width
      sizes = sizes.sort_by {|k,v| k.to_s }
    end
  
    def default_sizes
      {
        :huge   => "(min-width: 1600px)", 
        :large  => "(min-width: 1000px)", 
        :medium => "(min-width: 768px)", 
        :small  => "(min-width: 480px)",
        :tiny   => "(min-width: 320px)"
      }
    end
  
  end
end