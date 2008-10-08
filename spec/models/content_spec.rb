require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Content do
  before(:each) do
    @valid_attributes = {
      :title => "People Should Know Better",
      :body => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    }
  end
  
  it "should create a new instance given valid attributes" do
    Content.create(@valid_attributes)
  end
    
  describe "properties" do
    describe "with a title" do
      before(:each) do
        @content = Content.new(@valid_attributes)
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
        @content = Content.new(@valid_attributes.except(:title))
      end

      it "should not be valid" do
        @content.should_not be_valid
      end
    end

    describe "with a body" do
      before(:each) do
        @content = Content.new(@valid_attributes.merge(:body => "Not in summary. <summary>Summary.</summary> And something else."))
      end

      it "should be valid" do
        @content.should be_valid
      end
    end

    describe "without a body" do
      before(:each) do
        @content = Content.new(@valid_attributes.except(:body))
      end

      it "should not be valid" do
        @content.should_not be_valid
        @content.errors.on(:body).should_not be_nil
      end
    end
  end
end