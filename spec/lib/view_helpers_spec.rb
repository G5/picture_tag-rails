require 'spec_helper'
describe PictureTag::ViewHelpers, :type => :helper  do
  
  describe "split image path" do
    let(:split_image_path) { helper.split_image_path_from_extension("/path/something.s-original.jpg") }
    it "removes the -original" do
      split_image_path.first.should eq "/path/something.s"
    end
    
    it "splits jpg" do
      split_image_path.last.should eq "jpg"
    end
    
  end
  
  describe "building the source tag" do
    
    it "builds using a media query" do
      helper.build_source_tag('test', 'small', 'jpg', "(min-width: 100px)").
      should eq "<source media='(min-width: 100px)' srcset='/images/test-small.jpg 1x, /images/test-small@2x.jpg 2x' />"
    end
    
    it "builds without a media query" do
      helper.build_source_tag('/path/test', 'small', 'png').
      should eq "<source srcset='/path/test-small.png 1x, /path/test-small@2x.png 2x' />"
    end
    
    it "builds without an external path" do
      helper.build_source_tag('http://www.image/path/test', 'small', 'png',"(min-width: 100px)").
      should eq "<source media='(min-width: 100px)' srcset='http://www.image/path/test-small.png 1x, http://www.image/path/test-small@2x.png 2x' />"
    end
  end
  
  describe "default source and image" do
    it "builds source and img" do
      helper.add_default_source_and_image('test', 'small', 'jpg', {}).
      should eq "<source srcset='/images/test-small.jpg 1x, /images/test-small@2x.jpg 2x' /><img alt=\"Test\" src=\"/images/test-small.jpg\" />"
    end
    
    it "adds a class to the img tag" do
      helper.add_default_source_and_image('test', 'small', 'jpg', {:class => "span2"}).
      should eq "<source srcset='/images/test-small.jpg 1x, /images/test-small@2x.jpg 2x' /><img alt=\"Test\" class=\"span2\" src=\"/images/test-small.jpg\" />"
    end
    
  end
  
  describe "determine sizes" do
    let(:sizes) { {:huge => "(min-width: 1600px)", :small => "(min-width: 500px)"} }
    it "puts the hash into a sorted array" do
      helper.determine_sizes(:sizes => sizes).should eq [[:huge, "(min-width: 1600px)"], [:small, "(min-width: 500px)"]]
    end
    
    it "excludes sizes larger than tha max_width" do
      helper.determine_sizes(:sizes => sizes, :max_width => "501px" ).should eq [[:small, "(min-width: 500px)"]]
    end
    
    it "keeps with an equal max width" do
      helper.determine_sizes(:sizes => sizes, :max_width => "500px" ).should eq [[:small, "(min-width: 500px)"]]
    end

    it "removes with a lesser max width" do
      helper.determine_sizes(:sizes => sizes, :max_width => "499px" ).should eq []
    end
    
  end
  
  describe "options" do
    def html
      "<picture>" +
      "<source media='(min-width: 1600px)' srcset='/images/cat-huge.jpg 1x, /images/cat-huge@2x.jpg 2x' />" +
      "<source media='(min-width: 1000px)' srcset='/images/cat-large.jpg 1x, /images/cat-large@2x.jpg 2x' />" +
      "<source media='(min-width: 768px)' srcset='/images/cat-medium.jpg 1x, /images/cat-medium@2x.jpg 2x' />" +
      "<source media='(min-width: 480px)' srcset='/images/cat-small.jpg 1x, /images/cat-small@2x.jpg 2x' />" +
      "<source media='(min-width: 320px)' srcset='/images/cat-tiny.jpg 1x, /images/cat-tiny@2x.jpg 2x' />" +
      "<source srcset='/images/cat-tiny.jpg 1x, /images/cat-tiny@2x.jpg 2x' />" +
      "<img alt=\"Cat\" src=\"/images/cat-tiny.jpg\" />" +
      "</picture>"
    end


    it  "matches the complete html" do
      helper.picture_tag('/images/cat.jpg').should eq html 
    end

    it  "matches the complete html with an alt tag" do
      helper.picture_tag('/images/cat.jpg', :alt => "Kitty!").should eq html.gsub("Cat", "Kitty!") 
    end

    it "overwrites the default sizes if sizes given" do
      h = "<picture>" +
      "<source media='(min-width: 1px)' srcset='/images/cat-hidden.jpg 1x, /images/cat-hidden@2x.jpg 2x' />" +
      "<source srcset='/images/cat-hidden.jpg 1x, /images/cat-hidden@2x.jpg 2x' />" +
      "<img alt=\"Cat\" src=\"/images/cat-hidden.jpg\" />" +
      "</picture>"

      helper.picture_tag('/images/cat.jpg', :sizes => {:hidden => "(min-width: 1px)"}).
      should eq h
    end
    
    it "excludes source tags with a media query above the given amount" do
      helper.picture_tag("cat.jpg", :max_width => "500").split('source').should have(4).things
    end
  end
  
end