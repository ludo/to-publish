class Category
  include DataMapper::Resource

  # === Properties
  property :id, Serial
  property :title, String, :nullable => false, :length => 64
  property :description, String, :length => 256
  
  # === Associations
  has n, :articles, :through => Resource
  
  # === Validations
  validates_is_unique :title
  
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
end
