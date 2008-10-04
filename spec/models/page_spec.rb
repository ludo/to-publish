require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module PageSpecHelper
  def valid_properties
    { :title => "People Should Know Better",
      :body => "
        <page_title />
        <page_timestamp />
        
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
        
        <page_summary>
        <p>Nullam blandit magna et neque. Phasellus vel diam eu sem porta
        aliquam. Aliquam erat volutpat. Donec viverra. Vestibulum rhoncus, urna
        eu rhoncus dignissim, elit orci pharetra pede, ut cursus neque tortor
        vitae orci. Nunc pretium sapien nec sulla. Pellentesque habitant morbi
        tristique senectus et netus et malesuada fames ac turpis egestas.
        Suspendisse ultrices libero nec justo. Maecenas ultraces egestas
        libero. Nulla vitae nibh. Vestibulum augue libero, tristique elementum,
        scelerisque ac, dapibus ut, diam.</p>
        </page_summary>
        
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

describe Page do
  include PageSpecHelper
  
  it "should create a new instance given valid attributes" do
    Page.create(valid_properties)
  end
    
  describe "properties" do
    describe "with a title" do
      before(:each) do
        @page = Page.new(valid_properties)
      end

      it "should be valid" do
        @page.should be_valid
      end

      it "should generate a slug based on the title" do
        @page.should be_valid
        @page.slug.should == @page.title.to_slug
      end

      it "should return the title when stringified" do
        @page.to_s.should == @page.title
      end
    end

    describe "without a title" do
      before(:each) do
        @page = Page.new(valid_properties.except(:title))
      end

      it "should not be valid" do
        @page.should_not be_valid
      end
    end

    describe "with a body" do
      before(:each) do
        @page = Page.new(valid_properties.merge(:body => "Not in summary. <page_summary>Summary.</page_summary> And something else."))
      end

      it "should be valid" do
        @page.should be_valid
      end

      it "should produce a summary if possible" do
        @page.summary?.should == true
        @page.summary.should == "Summary."
      end

      it "should not produce a summary when not available" do
        @page.body = "<p>Something without page summary tags.</p>"
        @page.summary?.should == false
        @page.summary.should == nil
      end

      it "without <page_summary> should not produce a summary" do
        @page.body = "<p>Something with the end tag for an page summary,
          but without the start tag: </page_summary></p>"
        @page.summary?.should == false
        @page.summary.should == nil
      end

      it "without </page_summary> should not produce a summary" do
        @page.body = "<p>Something with a start tag for an page summary,
          but without the end tag: <page_summary></p>"
        @page.summary?.should == false
        @page.summary.should == nil
      end
    end

    describe "without a body" do
      before(:each) do
        @page = Page.new(valid_properties.except(:body))
      end

      it "should not be valid" do
        @page.should_not be_valid
        @page.errors.on(:body).should_not be_nil
      end
    end
  end

  describe "with comments" do
    describe "enabled" do
      before(:each) do
        @page = Page.new(valid_properties.merge(:published_at => Date.today))
      end
    
      it "should allow comments" do
        @page.comments_allowed?.should == true
      end
    
      it "should be published no longer than 30 days ago" do
        @page.published_at.should > Date.today - 30
      end
    end

    describe "disabled" do
      before(:each) do
        @page = Page.new(valid_properties.merge(:published_at => Date.today - 40.days))
      end

      it "should not allow comments" do
        @page.comments_allowed?.should == false
      end
    
      it "should have been published more than 30 days ago" do
        @page.published_at.should < Date.today - 30
      end
    end
  end
end