# PictureTag

A ViewHelper picture_tag extension to give a image_tag like helper for the proposed HTML5 picture element

## Installation

Add this line to your application's Gemfile:

    gem 'picture_tag'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install picture_tag

## Usage

```ruby
picture_tag(image_path, options)
```  

```ruby
picture_tag('cat.jpg', alt: "Kitty cat!")
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

## Options
To exclude <source> attributes above a max width:
  
```ruby
picture_tag(image_path, max_width: 600)
```