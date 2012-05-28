class CommentsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create!(params[:comment])
    @comment.update_attributes(:user_id => current_user.id)
    @comment.save
    redirect_to @article, :notice => "Comment created!"  
  end

end
