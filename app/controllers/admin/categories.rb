module Admin
  class Categories < Base
    # provides :xml, :yaml, :js
  
    def index
      @categories = Category.all
      display @categories
    end
  
    def show
      @category = Category.get(params[:id])
      raise NotFound unless @category
      display @category
    end
  
    def new
      only_provides :html
      @category = Category.new
      render
    end
  
    def edit
      only_provides :html
      @category = Category.get(params[:id])
      raise NotFound unless @category
      render
    end
  
    def create
      @category = Category.new(params[:category])
      if @category.save
        redirect url(:admin_categories)
      else
        render :new
      end
    end
  
    def update
      @category = Category.get(params[:id])
      raise NotFound unless @category
      if @category.update_attributes(params[:category]) || !@category.dirty?
        redirect url(:admin_categories)
      else
        raise BadRequest
      end
    end
  
    def destroy
      @category = Category.get(params[:id])
      raise NotFound unless @category
      if @category.destroy
        redirect url(:admin_categories)
      else
        raise BadRequest
      end
    end
  
  end # Categories
end # Admin
