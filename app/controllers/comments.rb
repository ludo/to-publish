class Comments < Application
  
  def create
    @comment = Comment.new(params[:comment])
    if Article.get(params[:comment][:content_id]).comments_allowed? && @comment.save
      redirect path_to_content(@comment.article)
    else
      raise BadRequest
    end
  end
  
end
