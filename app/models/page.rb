class Page < Content
  
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