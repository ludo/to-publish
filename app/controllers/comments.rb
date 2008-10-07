class Comments < Application
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect path_to_content(@comment.content)
    else
      raise BadRequest
    end
  end
  
end
