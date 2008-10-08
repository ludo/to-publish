require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Category do
  before(:each) do
    Category.all.destroy!
    
    @valid_attributes = {
      :title => "Programming"
    }
  end

  describe "properties" do
    describe "with a title" do
      before(:each) do
        @category = Category.new(@valid_attributes)
      end
      
      it "should be valid" do
        @category.should be_valid
      end
      
      it "should be unique" do
        Category.create(@valid_attributes)
        @category.should_not be_valid
        @category.errors.on(:title).should_not be_nil
      end
      
      it "should return the title when stringified" do
        @category.to_s.should == @category.title
      end
    end
    
    describe "without a title" do
      before(:each) do
        @category = Category.new(@valid_attributes.except(:title))
      end
      
      it "should not be valid" do
        @category.should_not be_valid
      end
    end
    
    describe "with a description" do
      before(:each) do
        @category = Category.new(@valid_attributes.merge(:description => "Foo"))
      end
      
      it "should be valid" do
        @category.should be_valid
      end
    end
    
    describe "without a description" do
      before(:each) do
        @category = Category.new(@valid_attributes.except(:description))
      end
      
      it "should be valid" do
        @category.should be_valid
      end
    end
  end

end