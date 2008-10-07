class Comment
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :title, String, :nullable => false, :length => 64
  property :body, Text, :nullable => false #, :lazy => false Is this neccessary?
  property :author, String, :length => 64, :nullable => false
  property :email, String, :length => 128
  property :website, String, :length => 128
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # === Associations
  belongs_to :content
  
  # === Class Methods
  class << self
    
    def prepare(content)
      Comment.new(:content_id => content.id, :title => "Re: #{content.title}")
    end
    
  end
end
