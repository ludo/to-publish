class Articles < Application
  def index
    provides :html, :atom
    
    @articles = Article.published(:order => [:published_at.desc], :limit => 10)
    @articles.empty? ? render(:empty) : display(@articles)
  end
  
  def archive
    render (Article.count > 0) ? :archive : :empty
  end
  
  def archive_by_date
    year, month, day = params[:year], params[:month], params[:day]
    
    if params[:day]
      template = :day
      date = "#{year}-#{month}-#{day}"
    elsif params[:month]
      template = :month
      date = "#{year}-#{month}"
    elsif params[:year]
      template = :year
      date = "#{year}"
    end

    @date = Time.parse("#{year || Time.now.year}-#{month || 1}-#{day || 1}")

    @articles = Article.all(
      :published_at.like => "#{date}%",
      :order => [:published_at.desc]
    )
    
    display @articles, template
  end
  
  def show
    date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")

    @article = Article.first(
      :slug => params[:slug],
      :published_at.gte => date
    )

    raise NotFound unless @article
    display @article
  end
end