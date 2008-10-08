require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Page do
  before(:each) do
    @valid_attributes = {
      :title => "About Me",
      :body => "Information about me, the author!"
    }
  end
  
  describe "properties" do
    describe "with a title" do
      before(:each) do
        @page = Page.new(@valid_attributes)
      end
      
      it "should be unique" do
        Page.create(@valid_attributes)
        @page.should_not be_valid
        @page.errors.on(:title).should_not be_nil
      end
    end
    
    describe "with a slug" do
      before(:each) do
        @page = Page.new(@valid_attributes)
      end
      
      it "should be unique" do
        Page.create(@valid_attributes)
        @page.should_not be_valid
        @page.errors.on(:slug).should_not be_nil
      end
    end
  end
end