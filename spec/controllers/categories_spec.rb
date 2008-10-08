require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Categories, "index action" do
  before(:each) do
    dispatch_to(Categories, :index)
  end
end