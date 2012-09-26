# Picture-Tag Rails

A Rails view helper extension to generate HTML5 `<picture>` tag markup
from the W3C HTML Responsive Images Extension Proposal.
  
[w3.org/community/respimg](http://www.w3.org/community/respimg)


## Current Version

0.0.2


## Requirements

* [Ruby on Rails](http://rubyonrails.org) > 3.0



## Installation

### Gemfile

Add this line to your application's Gemfile.

```ruby
gem 'picture_tag-rails'
```

### Manual

Or install it yourself.

```bash
gem install picture_tag-rails
```


## Usage

Add to some Ruby file in your Rails app.

```ruby
require 'picture_tag'
```

Use it in your views as you would the `image_tag()` helper.

```erb
<%= picture_tag(image_path, options) %>
```


## Examples

The vanilla usage with default sizes and media queries:

```erb
<%= picture_tag("cat.jpg", alt: "Kitty cat!") %>
```

produces:

```html
<picture>
  <source media="(min-width: 1600px)" srcset="cat-large.jpg 1x, cat-large@2x.jpg 2x" />
  <source media="(min-width: 1000px)" srcset="cat-medium.jpg 1x, cat-medium@2x.jpg 2x" />
  <source media="(min-width: 768px)"  srcset="cat-small.jpg 1x, cat-small@2x.jpg 2x" />
  <source media="(min-width: 480px)"  srcset="cat-tiny.jpg 1x, cat-tiny@2x.jpg 2x" />
  <source srcset="cat-tiny.jpg 1x, cat-tiny@2x.jpg 2x" />
  <img alt="Kitty cat!" src="cat-tiny.jpg" />
</picture>
```

### Options

To exclude certain `<source>` elements with media queries above a max width:

```erb
<%= picture_tag(image_path, max_width: "600px") %>
```

To override the default media queries and names:

```erb
<%= picture_tag(image_path, sizes: { itty_bitty: "(min-width: 10px)" }) %>
```

All `image_tag` options are valid for `picture_tag`.
See [image_tag Docs](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html)


## Paperclip

Paperclip options for default media queries and sizes.

```ruby
has_attached_file :image, {
  styles: { 
    tiny:   "320x", 
    small:  "480x", 
    medium: "768x", 
    large:  "1000x", 
    huge:   "1600x",
    %s(tiny@2x)   => "640x", 
    %s(small@2x)  => "960x", 
    %s(medium@2x) => "1536x", 
    %s(large@2x)  => "2000x", 
    %s(large@2x)  => "3200x"
  }
```


## TODO

- Add optional paperclip integration functionality
- Implement Retina support


## Authors

* Bookis Smuin / [@bookis](https://github.com/bookis)
* Chad Crissman / [@crissmancd](https://github.com/crissmancd)


## Contributions

1. Fork it
2. Get it running (see Installation above)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Write your code and **specs**
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/G5/picture_tag-rails/issues).

### Specs

```bash
rake spec
```

### Releases

```bash
TODO how do you do a release?
```


## License

Copyright (c) 2012 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.