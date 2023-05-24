class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])  # データ（レコード）を1件取得
    @comment.destroy  # データ（レコード）を削除
    redirect_to  admin_comments_path(@comment) # 投稿一覧画面へリダイレクト
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
