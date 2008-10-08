require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Admin::Categories, "index action" do
  before(:each) do
    dispatch_to(Admin::Categories, :index)
  end
end