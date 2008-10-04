class Page
  include DataMapper::Resource

  # === Properties
  property :id, Integer, :serial => true
  property :type, Discriminator
  property :title, String, :nullable => false, :length => 64
  property :slug, String, :nullable => false, :length => 64
  property :body, Text, :nullable => false
  property :published_at, DateTime
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # === Callbacks
  before :valid?, :set_slug
  
  # === Instance Methods  
  
  # Determine whether posting comments is allowed
  #
  # Posting comments should be automatically disabled after 30 days.
  #
  # ==== Returns
  # Boolean:: True if comments are allowed
  #
  # --
  # @api public
  def comments_allowed?
    published_at > Date.today - 30 ? true : false
  end
  
  # Set +published_at+
  #
  # Verify whether <tt>value</tt> is a <tt>Date</tt>. If this is not the case then
  # <tt>value</tt> will be set to <tt>nil</tt>.
  #
  # ==== Paramaters
  # value<String>:: Date on which this page should be published
  #
  # --
  # @api public
  def published_at=(value)
    value = nil if value.instance_of?(String) && value.length == 0
    attribute_set(:published_at, value)
  end
  
  # Set a slug to use in URIs
  #
  # If no user-defined slug is given, then the slug will be generated based on
  # the title for the post. A slug should consist of numbers (0-9), lowercase
  # letters (a-z) and dashes (-). Any other characters should be filtered.
  #
  # --
  # @api public
  def set_slug
    attribute_set(:slug, title.to_slug) if title
  end
  
  # Extract a summary from the page's body
  # 
  # ==== Returns
  # String:: A summary, extracted from +body+
  #
  # --
  # @api public
  def summary
    if summary?
      body.match(/<page_summary>(.*)<\/page_summary>/m)[1].strip
    end
  end
  
  def summary?
    body.include?("<page_summary>") && body.include?("</page_summary>")
  end
  
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
end
