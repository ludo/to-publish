class Pages < Application

  def show
    @page = Page.first(:slug => params[:slug])
    raise NotFound unless @page
    display @page
  end
  
end
