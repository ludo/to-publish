require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe Admin::Dashboard, "index action" do
  before(:each) do
    dispatch_to(Admin::Dashboard, :index)
  end
end