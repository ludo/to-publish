require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module ContentSpecHelper
  def valid_properties
    { :title => "People Should Know Better",
      :body => "
        <title />
        <timestamp />
        
        <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nullam sed
        sapien. Aliquam lacinia adipiscing massa. Nulla sit amet arcu. Nullam
        mauris. Maecenas egestas elit porttitor orci sodales iaculis. Integer
        aliquet. Aliquam erat volutpat. Etiam quis pede sed nisi consectetuer
        condimentum. Phasellus erat. Cras a sem id turpis posuere consectetuer.
        Duis nunc. Sed porttitor nisl a ipsum. Aenean vitae ante convallis erat
        malesuada lacinia. Phasellus condimentum cursus eros. Sed lorem libero,
        tempor id, ullamcorper non, lacinia in, dui. Donec ligula tortor, porta
        non, imperdiet scelerisque, scelerisque vitae, dui. Sed metus libero,
        mollis vitae, cursus ac, blandit in, purus.</p>" }
  end
end

describe Content do
  include ContentSpecHelper
  
  it "should create a new instance given valid attributes" do
    Content.create(valid_properties)
  end
    
  describe "properties" do
    describe "with a title" do
      before(:each) do
        @content = Content.new(valid_properties)
      end

      it "should be valid" do
        @content.should be_valid
      end

      it "should generate a slug based on the title" do
        @content.should be_valid
        @content.slug.should == @content.title.to_slug
      end

      it "should return the title when stringified" do
        @content.to_s.should == @content.title
      end
    end

    describe "without a title" do
      before(:each) do
        @content = Content.new(valid_properties.except(:title))
      end

      it "should not be valid" do
        @content.should_not be_valid
      end
    end

    describe "with a body" do
      before(:each) do
        @content = Content.new(valid_properties.merge(:body => "Not in summary. <summary>Summary.</summary> And something else."))
      end

      it "should be valid" do
        @content.should be_valid
      end
    end

    describe "without a body" do
      before(:each) do
        @content = Content.new(valid_properties.except(:body))
      end

      it "should not be valid" do
        @content.should_not be_valid
        @content.errors.on(:body).should_not be_nil
      end
    end
  end
end