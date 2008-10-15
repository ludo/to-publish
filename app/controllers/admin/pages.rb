module Admin
  class Pages < Base
    # provides :xml, :yaml, :js
  
    # GET /admin/pages
    def index
      @pages = Page.all
      display @pages
    end
  
    # GET /admin/pages/:id
    def show(id)
      @page = Page.get(id)
      raise NotFound unless @page
      display @page
    end
  
    # GET /admin/pages/new
    def new
      only_provides :html
      @page = Page.new
      display Page
    end
  
    # GET /admin/pages/:id/edit
    def edit(id)
      only_provides :html
      @page = Page.get(id)
      raise NotFound unless @page
      display @page
    end
  
    # POST /admin/pages
    def create(page)
      @page = Page.new(page)
      if @page.save
        redirect url(:admin_pages)
      else
        render :new
      end
    end
  
    # PUT /admin/pages/:id
    def update(page)
      @page = Page.get(params[:id])
      raise NotFound unless @page
      if @page.update_attributes(page)
        redirect url(:admin_pages)
      else
        display @page, :edit
      end
    end
  
    # DELETE /admin/pages/:id
    def destroy(id)
      @page = Page.get(id)
      raise NotFound unless @page
      if @page.destroy
        redirect url(:admin_pages)
      else
        raise InternalServerError
      end
    end
  
  end # Pages
end # Admin
