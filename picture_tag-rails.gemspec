# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'picture_tag-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "picture_tag-rails"
  gem.version       = PictureTag::VERSION
  gem.authors       = ["Bookis Smuin"]
  gem.email         = ["vegan.bookis@gmail.com"]
  gem.description   = %q{Rails View Helper picture_tag extension}
  gem.summary       = %q{A Rails view helper extension to generate the proposed HTML5 picture tag markup.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '>= 3.0', '<4.0.0'
end
