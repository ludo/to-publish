module Admin
  class Pages < Base
    # provides :xml, :yaml, :js
  
    def index
      @pages = Page.all
      display @pages
    end
  
    def show
      @page = Page.get(params[:id])
      raise NotFound unless @page
      display @page
    end
  
    def new
      only_provides :html
      @page = Page.new
      render
    end
  
    def edit
      only_provides :html
      @page = Page.get(params[:id])
      raise NotFound unless @page
      render
    end
  
    def create
      @page = Page.new(params[:page])
      if @page.save
        redirect url(:admin_pages)
      else
        render :new
      end
    end
  
    def update
      @page = Page.get(params[:id])
      raise NotFound unless @page
      if @page.update_attributes(params[:page]) || !@page.dirty?
        redirect url(:admin_pages)
      else
        raise BadRequest
      end
    end
  
    def destroy
      @page = Page.get(params[:id])
      raise NotFound unless @page
      if @page.destroy
        redirect url(:admin_pages)
      else
        raise BadRequest
      end
    end
  
  end # Pages
end # Admin
