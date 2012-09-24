# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'responsive_picture/version'

Gem::Specification.new do |gem|
  gem.name          = "responsive-picture"
  gem.version       = Responsive::Picture::VERSION
  gem.authors       = ["Bookis Smuin"]
  gem.email         = ["vegan.bookis@gmail.com"]
  gem.description   = %q{Rails View Helper picture_tag extension}
  gem.summary       = %q{Allow a picture_tag method to generate dynamic markup for the proposed HTML5 picture element}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
