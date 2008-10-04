class Article < Content
  # === Associations
  # has n, :comments
  
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
end