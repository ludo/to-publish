require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module ArticleSpecHelper
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
        mollis vitae, cursus ac, blandit in, purus.</p>
        
        <summary>
        <p>Nullam blandit magna et neque. Phasellus vel diam eu sem porta
        aliquam. Aliquam erat volutpat. Donec viverra. Vestibulum rhoncus, urna
        eu rhoncus dignissim, elit orci pharetra pede, ut cursus neque tortor
        vitae orci. Nunc pretium sapien nec sulla. Pellentesque habitant morbi
        tristique senectus et netus et malesuada fames ac turpis egestas.
        Suspendisse ultrices libero nec justo. Maecenas ultraces egestas
        libero. Nulla vitae nibh. Vestibulum augue libero, tristique elementum,
        scelerisque ac, dapibus ut, diam.</p>
        </summary>
        
        <p>In hac habitasse platea dictumst. Sed felis nunc, malesuada eget,
        eleifend in, molestie nec, purus. Vestibulum ante ipsum primis in
        faucibus orci luctus et ultrices posuere cubilia Curae; Fusce laoreet
        tortor non mi volutpat pellentesque. Aenean ante risus, varius id,
        pharetra quis, cursus in, nisi. In sodales imperdiet mauris.
        Suspendisse sed elit. Vivamus eu mi pharetra nibh ullamcorper iaculis.
        Curabitur nec pede ac velit facilisis venenatis. Aenean at pede. Donec
        in elit.</p>" }
  end
end

describe Article do
  include ArticleSpecHelper
  
  describe "properties" do
    describe "with a body" do
      before(:each) do
        @article = Article.new(valid_properties.merge(:body => "Not in summary. <summary>Summary.</summary> And something else."))
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
  
  describe "with comments" do
    describe "enabled" do
      before(:each) do
        @article = Article.new(valid_properties.merge(:published_at => Date.today))
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
        @article = Article.new(valid_properties.merge(:published_at => Date.today - 40.days))
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