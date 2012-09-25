# picture_tag

A Rails view helper extension to generate the proposed HTML5 picture tag markup.

## Installation

Add this line to your application's Gemfile:

`gem 'picture_tag-rails'`

Or install it yourself as:

`gem install picture_tag-rails`

## Usage

```erb
<%= picture_tag(image_path, options) %>
```  

With default sizes and media queries
```erb
<%= picture_tag('/images/cat.jpg', alt: "Kitty cat!") %>
```  

produces

```html
<picture>
  <source media='(min-width: 1600px)' srcset='/images/cat-large.jpg 1x, /images/cat-large@2x.jpg 2x' />
  <source media='(min-width: 1000px)' srcset='/images/cat-medium.jpg 1x, /images/cat-medium@2x.jpg 2x' />
  <source media='(min-width: 768px)' srcset='/images/cat-small.jpg 1x, /images/cat-small@2x.jpg 2x' />
  <source media='(min-width: 480px)' srcset='/images/cat-tiny.jpg 1x, /images/cat-tiny@2x.jpg 2x' />
  <source srcset='/images/cat-tiny.jpg 1x, /images/cat-tiny@2x.jpg 2x' />
  <img alt=\"Kitty cat!\" src=\"/images/cat-tiny.jpg\" />
</picture>
```

## Paperclip

Paperclip options for default media queries and sizes

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

## Options

To exclude `<source>` elements with media queries above a max width:
```erb
<%= picture_tag(image_path, max_width: "600px") %>
```

To override the default media queries and names:
```erb
<%= picture_tag(image_path, sizes: {itty_bitty: "(min-width: 10px)"}) %>
```

All `image_tag` options are valid for `picture_tag`. See [image_tag Docs](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html)

## Todo

- Add optional paperclip integration functionality
- Implement Retina support