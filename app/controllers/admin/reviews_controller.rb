class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def destroy
    @review = Review.find(params[:id])  # データ（レコード）を1件取得
    @review.destroy  # データ（レコード）を削除@reviewを消去
    redirect_to review_path(@review.id)  # 投稿一覧画面へリダイレクト
  end

  private
  
  # ストロングパラメータ
  def review_params
    params.require(:review).permit(:review_title, :review_body, :image, :tennis_court_id)
  end
end
