module PictureTag
  module ViewHelpers
    
    def picture_tag(image_path, options={})
      sizes = determine_sizes(options)
      
      html = "<picture>"
      sizes.each do |size, media_query| 
        html << build_source_tag(image_path, size, media_query, options)
      end
      html << add_default_source_and_image(image_path, sizes.last.first, options)
      html << "</picture>"
      
      html
    end
  
    def build_file_path(image_path, size, prefix_size=false)
      filename, extension = split_image_path_from_extension(image_path)
      if prefix_size
        path, file = filename.split(/\/(?=[^\/]+(?: |$))| /)
        if file.nil?
          file = path
          "#{size}-#{file}.#{extension}"
        else
          "#{path}/#{size}-#{file}.#{extension}"
        end
      else
        "#{filename}-#{size}.#{extension}"
      end
    end
  
    def build_source_tag(image_path, size, media_query=nil, options={})
      file   = build_file_path(image_path, size, options[:prefix_size])
      file2x = build_file_path(image_path, "#{size}@2x", options[:prefix_size])
      srcset = image_path(file)    + " 1x, "
      srcset << image_path(file2x) + " 2x"
      "<source #{"media='#{media_query}' " if media_query}srcset='#{srcset}' />"
    end
  
    def add_default_source_and_image(image_path, size, options)
      html = build_source_tag(image_path, size)    
      filename, extension = split_image_path_from_extension(image_path)
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
    
    def split_image_path_from_extension(image_path)
      image_path.gsub!('-original', '')
      image_path.split(/\.(?=[^\.]+(?: |$))| /) # Splits on last period before the first whitespace.
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