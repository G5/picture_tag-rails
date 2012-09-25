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
<%= picture_tag('cat.jpg', alt: "Kitty cat!") %>
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
```erb
<%= picture_tag(image_path, max_width: "600px") %>
```

To override the default media queries and names:
```erb
<%= picture_tag(image_path, sizes: {itty_bitty: "(min-width: 10px)"}) %>
```

## Todo

- Implement Retina support