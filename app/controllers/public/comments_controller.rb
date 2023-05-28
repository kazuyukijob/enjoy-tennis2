class Public::CommentsController < ApplicationController

 def mycomment
  @comments = Comment.where(user_id: params[:user_id])
 end

 def create
   review = Review.find(params[:review_id])
   comment = current_user.comments.new(comment_params)
   comment.review_id = review.id
   comment.save
   @review = Review.find(params[:review_id])
   @comment = Comment.new
   redirect_to tennis_court_reviews_path(@review.tennis_court_id)#()の中はrailsが渡して欲しい物が入るrails routesのurlの:から始まる物を渡せるschemaでも確認可
 end

 def destroy
  @review = Review.find(params[:review_id])
  @comment = Comment.find_by(id: params[:id], review_id: params[:review_id])
  @comment.destroy
  @comment = Comment.new
  redirect_to tennis_court_reviews_path(@review.tennis_court_id)
 end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
