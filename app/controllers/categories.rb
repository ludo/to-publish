class Categories < Application

  def show
    @category = Category.get(params[:id])
    raise NotFound unless @category
    display @category
  end
  
end
