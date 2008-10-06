class Articles < Application
  def index
    provides :html, :atom
    
    @articles = Article.published(:order => [:published_at.desc], :limit => 10)
    @articles.empty? ? render(:empty) : display(@articles)
  end
  
  def show
    date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")

    @article = Article.first(
      :slug => params[:slug],
      :published_at => date
    )

    raise NotFound unless @article
    display @article
  end
end