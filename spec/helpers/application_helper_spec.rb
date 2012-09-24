require 'spec_helper'
describe ResponsivePicture::ViewHelpers, :type => :helper  do
  def html
    "<picture>" +
    "<source media='(min-width: 1600px)' srcset='/images/cat-large.jpg 1x, /images/cat-large@2x.jpg 2x' />" +
    "<source media='(min-width: 1000px)' srcset='/images/cat-medium.jpg 1x, /images/cat-medium@2x.jpg 2x' />" +
    "<source media='(min-width: 768px)' srcset='/images/cat-small.jpg 1x, /images/cat-small@2x.jpg 2x' />" +
    "<source media='(min-width: 480px)' srcset='/images/cat-tiny.jpg 1x, /images/cat-tiny@2x.jpg 2x' />" +
    "<source srcset='/images/cat-tiny.jpg 1x, /images/cat-tiny@2x.jpg 2x' />" +
    "<img alt=\"Cat\" src=\"/images/cat-tiny.jpg\" />" +
    "</picture>"
  end
  
  it  "matches the complete html" do
    helper.picture_tag('/images/cat.jpg').should eq html 
  end
  
  it  "matches the complete html with an alt tag" do
    helper.picture_tag('/images/cat.jpg', alt: "Kitty!").should eq html.gsub("Cat", "Kitty!") 
  end
  
  describe "split image path" do
    let(:split_image_path) { helper.split_image_path("/path/something.s-original.jpg") }
    it "removes the -original" do
      split_image_path.first.should eq "/path/something.s"
    end
    
    it "splits jpg" do
      split_image_path.last.should eq "jpg"
    end
    
  end
  
  describe "building the source tag" do
    
    it "builds using a media query" do
      helper.create_source('test', 'small', 'jpg', "(min-width: 100px)").
      should eq "<source media='(min-width: 100px)' srcset='/images/test-small.jpg 1x, /images/test-small@2x.jpg 2x' />"
    end
    
    it "builds without a media query" do
      helper.create_source('/path/test', 'small', 'png').
      should eq "<source srcset='/path/test-small.png 1x, /path/test-small@2x.png 2x' />"
    end
    
    it "builds without an external path" do
      helper.create_source('http://www.image/path/test', 'small', 'png',"(min-width: 100px)").
      should eq "<source media='(min-width: 100px)' srcset='http://www.image/path/test-small.png 1x, http://www.image/path/test-small@2x.png 2x' />"
    end
  end
  
  describe "default source and image" do
    it "builds source and img" do
      helper.add_default_source_and_image('test', 'small', 'jpg', {}).
      should eq "<source srcset='/images/test-small.jpg 1x, /images/test-small@2x.jpg 2x' /><img alt=\"Test\" src=\"/images/test-small.jpg\" />"
    end
    
    it "adds a class to the img tag" do
      helper.add_default_source_and_image('test', 'small', 'jpg', {class: "span2"}).
      should eq "<source srcset='/images/test-small.jpg 1x, /images/test-small@2x.jpg 2x' /><img alt=\"Test\" class=\"span2\" src=\"/images/test-small.jpg\" />"
    end
    
  end
  
end