module Admin
  class Articles < Base
    # provides :xml, :yaml, :js
  
    # GET /admin/articles
    def index
      @articles = Article.published(:order => [:published_at.desc])
      display @articles
    end
  
    # GET /admin/articles/:id
    def show(id)
      @article = Article.get(id)
      raise NotFound unless @article
      display @article
    end
  
    # GET /admin/articles/new
    def new
      only_provides :html
      @article = Article.new
      display Article
    end
  
    # GET /admin/articles/:id/edit
    def edit(id)
      only_provides :html
      @article = Article.get(id)
      raise NotFound unless @article
      display @article
    end
  
    # POST /admin/articles
    def create(article)
      @article = Article.new(article)
      @article.categories = Category.all(:id.in => params[:category_ids])
      if @article.save
        redirect url(:admin_articles), :message => {:notice => "Article was successfully created"}
      else
        render :new
      end
    end
  
    # PUT /admin/articles/:id
    def update(article)
      @article = Article.get(params[:id])
      raise NotFound unless @article
      
      # TODO Find a prettier/less db intensive way of doing this
      @article.article_categories.destroy!
      @article.categories = Category.all(:id.in => params[:category_ids])
      
      if @article.update_attributes(article)
        redirect url(:admin_articles), :message => {:notice => "Article was successfully updated"}
      else
        display @article, :edit
      end
    end
  
    # DELETE /admin/articles/:id
    def destroy(id)
      @article = Article.get(id)
      raise NotFound unless @article
      if @article.destroy
        redirect url(:admin_articles), :message => {:notice => "Article was successfully deleted"}
      else
        raise InternalServerError
      end
    end
  
  end # Articles
end # Admin
