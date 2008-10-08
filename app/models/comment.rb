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
  # TODO This thing creates a column named :content_id, but I want article_id
  belongs_to :article
  
  # === Instance Methods
  
  # Return the title when stringified
  #
  # ===== Returns
  # String:: The title
  #
  # --
  # @api public
  def to_s
    title
  end
  
  # === Class Methods
  class << self
    
    def prepare(content)
      Comment.new(:content_id => content.id, :title => "Re: #{content.title}")
    end
    
  end
end
