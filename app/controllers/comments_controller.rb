class CommentsController < ApplicationController
  def create
    @advert = Advert.find(comment_params[:advert_id])
    @comment = @advert.comments.create(comment_params)
    if @comment.save
      render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
    else
      render :js => "alert('error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('error deleting comment');"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :advert_id, :user_id, :comment)
  end
end
