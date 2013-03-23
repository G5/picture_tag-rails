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

    def build_file_path(image_path, size, prefix_size=false, options={})
      filename, extension = split_image_path_from_extension(image_path)
      if prefix_size
        # Splits on last '/' before the first whitespace.
        path, file = filename.split(/\/(?=[^\/]+(?: |$))| /)
        file ? "#{path}/#{size}-#{file}.#{extension}" : "#{size}-#{path}.#{extension}"
      elsif options[:default_image]
        #binding.pry
        image_path
      else
        "#{filename}-#{size}.#{extension}"
      end
    end

    def build_source_tag(image_path, size, media_query=nil, options={})
      file   = build_file_path(image_path, size, options[:prefix_size])
      file2x = build_file_path(image_path, "#{size}@2x", options[:prefix_size])
      srcset = image_path(file)    + " 1x, "
      srcset << image_path(file2x) + " 2x"
      srcset = options[:default_image] if options[:default_image].eql?(image_path)
      "<source #{"media='#{media_query}' " if media_query}srcset='#{srcset}' />"
    end
    
    def add_default_source_and_image(image_path, size, options)
      prefix_size = options[:prefix_size]
      if options[:default_image]
        prefix_size = false
        image_path = options[:default_image]
        size = nil
      elsif options[:default_size]
        options[:prefix_size] = false
        size = options[:default_size]
      end
      
      img_src = build_file_path(image_path, size, prefix_size, options)
      html    = build_source_tag(image_path, size, nil, options)
      html    << image_tag(img_src, normalize_options(options, image_path))
      html
    end

    def normalize_options(options, image_path)
      options[:alt] ||= alt_tag(image_path)
      options[:prefix_size]   = nil
      options[:max_width]     = nil
      options[:default_size]  = nil
      options[:default_image] = nil
      options
    end

    def alt_tag(image_path)
      filename, extension = split_image_path_from_extension(image_path)
      filename.split('/').last.capitalize
    end

    def determine_sizes(options)
      sizes = options.delete(:sizes) || default_sizes
      max_width = options[:max_width].to_i if options[:max_width]
      sizes = sizes.delete_if {|k,query| query.match(/\d+/)[0].to_i > max_width } if max_width
      sizes = sizes.sort_by {|k,v| k.to_s }
    end

    def split_image_path_from_extension(image_path)
      image_path.gsub!('-original', '')
      # Splits on last period before the first whitespace.
      image_path.split(/\.(?=[^\.]+(?: |$))| /)
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