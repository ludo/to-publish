require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Admin::Articles do
  describe "#index" do
    it "should fetch all articles" do 
      Article.should_receive(:published)

      dispatch_to(Admin::Articles, :index) do |controller| 
        controller.stub!(:display) 
      end 
    end 
  end

  describe "#new" do 
    before(:each) do 
      @article = Article.new
    end 
 
    it "should set-up a new Article" do 
      Article.stub!(:new).and_return(@article)
 
      dispatch_to(Admin::Articles, :new) do |controller| 
        controller.should_receive(:render) 
      end 

      assigns(:article).should == @article
    end
  end
end