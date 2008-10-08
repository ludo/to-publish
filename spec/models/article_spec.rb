require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Article do
  before(:each) do
    Article.all.destroy!
    
    @valid_attributes = {
      :title => "People Should Know Better",
      :body => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    }
  end
  
  describe "properties" do
    describe "with a body" do
      before(:each) do
        @article = Article.new(@valid_attributes.merge(:body => "Not in summary. <summary>Summary.</summary> And something else."))
      end

      it "should be valid" do
        @article.should be_valid
      end

      it "should produce a summary if possible" do
        @article.summary?.should == true
        @article.summary.should == "Summary."
      end

      it "should not produce a summary when not available" do
        @article.body = "<p>Something without summary tags.</p>"
        @article.summary?.should == false
        @article.summary.should == nil
      end

      it "without <summary> should not produce a summary" do
        @article.body = "<p>Something with the end tag for a summary, but without the start tag: </summary></p>"
        @article.summary?.should == false
        @article.summary.should == nil
      end

      it "without </summary> should not produce a summary" do
        @article.body = "<p>Something with a start tag for a summary, but without the end tag: <summary></p>"
        @article.summary?.should == false
        @article.summary.should == nil
      end
    end
  end
  
  describe "uniqueness" do
    before(:each) do
      @publish_at = Date.today
    end
    
    describe "of title" do
      before(:each) do
        Article.create(@valid_attributes.merge(:published_at => @publish_at))
      end
      
      it "should be guaranteed with scope on the publication date" do
        article = Article.new(@valid_attributes.merge(:published_at => @publish_at))
        article.should_not be_valid
        article.errors.on(:title).should_not be_nil
      end
      
      it "should be ignored by draft article" do
        article = Article.new(@valid_attributes.except(:published_at))
        article.should be_valid
      end
    end
  end
  
  describe "with comments" do
    describe "enabled" do
      before(:each) do
        @article = Article.new(@valid_attributes.merge(:published_at => Date.today))
      end
    
      it "should allow comments" do
        @article.comments_allowed?.should == true
      end
    
      it "should be published no longer than 30 days ago" do
        @article.published_at.should > Date.today - 30
      end
    end

    describe "disabled" do
      before(:each) do
        @article = Article.new(@valid_attributes.merge(:published_at => Date.today - 40.days))
      end

      it "should not allow comments" do
        @article.comments_allowed?.should == false
      end
    
      it "should have been published more than 30 days ago" do
        @article.published_at.should < Date.today - 30
      end
    end
  end
end