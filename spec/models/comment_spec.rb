require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module CommentSpecHelper
  def valid_properties
    { :title => "Re: What Are You Talking About?",
      :body => "Duh.",
      :author => "John Smith",
      :content_id => 1 }
  end
end

describe Comment do
  include CommentSpecHelper
  
  describe "properties" do
    describe "with an author" do
      before(:each) do
        @comment = Comment.new(valid_properties.merge(:author => "John Smith"))
      end
    
      it "should be valid" do
        @comment.should be_valid
      end
    end
  
    describe "without an author" do
      before(:each) do
        @comment = Comment.new(valid_properties.except(:author))
      end
    
      it "should not be valid" do
        @comment.should_not be_valid
        @comment.errors.on(:author).should_not be_nil
      end
    end
  end

  describe "for an article" do
    before(:each) do
      @article = Article.new(:title => "The Sun Is Shining")
      @comment = Comment.prepare(@article)
    end
  
    it "should be pre-populated with values" do
      @comment.title.should == "Re: #{@article.title}"
    end
  end
end