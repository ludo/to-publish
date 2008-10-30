module Admin
  class Dashboard < Base
  
    def index
      # TODO Atom feed!
      @events = []
      oldest = Time.now - 30.days
      
      @events += Comment.all(:created_at.gte => oldest, :order => [:created_at.desc])
      @events += Article.all(:published_at.gte => oldest, :order => [:published_at.desc])
      
      # Sort events
      @events.sort! do |x,y| 
        right = x.is_a?(Article) ? x.published_at : x.created_at
        left = y.is_a?(Article) ? y.published_at : y.created_at
        
        left <=> right
      end
      
      display @events
    end
    
  end
end # Admin
