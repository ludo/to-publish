module Admin
  class Categories < Base
    # provides :xml, :yaml, :js
  
    # GET /admin/categories
    def index
      @categories = Category.all(:order => [:title])
      display @categories
    end
  
    # GET /admin/categories/:id
    def show(id)
      @category = Category.get(id)
      raise NotFound unless @category
      display @category
    end
  
    # GET /admin/categories/new
    def new
      only_provides :html
      @category = Category.new
      display Category
    end
  
    # GET /admin/categories/:id/edit
    def edit(id)
      only_provides :html
      @category = Category.get(id)
      raise NotFound unless @category
      display @category
    end
  
    # POST /admin/categories
    def create(category)
      @category = Category.new(category)
      if @category.save
        redirect url(:admin_categories), :message => {:notice => "Category was successfully created"}
      else
        render :new
      end
    end
  
    # PUT /admin/categories/:id
    def update(category)
      @category = Category.get(params[:id])
      raise NotFound unless @category
      if @category.update_attributes(category)
        redirect url(:admin_categories), :message => {:notice => "Category was successfully updated"}
      else
        display @category, :edit
      end
    end
  
    # DELETE /admin/categories/:id
    def destroy(id)
      @category = Category.get(id)
      raise NotFound unless @category
      if @category.destroy
        redirect url(:admin_categories), :message => {:notice => "Category was successfully deleted"}
      else
        raise InternalServerError
      end
    end
  
  end # Categories
end # Admin
