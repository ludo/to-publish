class Content
  include DataMapper::Resource

  # === Properties
  property :id, Serial
  property :type, Discriminator
  property :title, String, :nullable => false, :length => 64
  property :slug, String, :nullable => false, :length => 64
  property :body, Text, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # === Callbacks
  before :valid?, :set_slug
  
  # === Instance Methods  
  
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
