class Article < Content
  # === Properties
  property :published_at, DateTime

  # === Associations
  belongs_to :category
  has n, :comments
  
  # === Validations
  validates_with_method :title, :method => :check_published_title_is_unique
  
  # === Instance Methods  
  
  def check_published_title_is_unique
    if(published_at && Article.count(:id.not => id, :title => title, :published_at.like => "#{published_at.strftime('%Y-%m-%d')}%") > 0)
      [false, "Title is already taken on this publication date."]
    else
      return true
    end
  end
  
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
  # value<String>:: Date on which this content should be published
  #
  # --
  # @api public
  def published_at=(value)
    value = nil if value.instance_of?(String) && value.length == 0
    attribute_set(:published_at, value)
  end
  
  # Extract a summary from the content's body
  # 
  # ==== Returns
  # String:: A summary, extracted from +body+
  #
  # --
  # @api public
  def summary
    if summary?
      body.match(/<summary>(.*)<\/summary>/m)[1].strip
    end
  end
  
  # Determines whether content contains a summary
  #
  # ==== Returns
  # Boolean:: True if summary is found
  #
  # --
  # @api public
  def summary?
    body.include?("<summary>") && body.include?("</summary>")
  end
  
  # === Class Methods
  class << self
    # Find all content that has not been published yet
    def drafts(conditions = {})
      all(conditions.merge(
        :published_at => nil
      ))
    end

    # Find all published content
    def published(conditions = {})
      all(conditions.merge(
        :published_at.not => nil
      ))
    end
  end
end