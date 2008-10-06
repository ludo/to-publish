require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Admin::Pages do
  describe "#index" do
    it "should fetch all pages" do 
      Page.should_receive(:all)

      dispatch_to(Admin::Pages, :index) do |controller| 
        controller.stub!(:display) 
      end 
    end 
  end

  describe "#new" do 
    before(:each) do 
      @page = Page.new
    end 
 
    it "should set-up a new Page" do 
      Page.stub!(:new).and_return(@page)
 
      dispatch_to(Admin::Pages, :new) do |controller| 
        controller.should_receive(:render) 
      end 

      assigns(:page).should == @page
    end
  end
end