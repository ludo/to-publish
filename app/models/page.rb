class Page < Content
  
  # === Validations
  validates_is_unique :slug, :title
  
  # === Class Methods
  class << self
    
    # Find all pubished pages
    def published(*args)
      #with_scope(
      #  :order => [:title]
      #) do
        super(*args)
      #end
    end
  end
end