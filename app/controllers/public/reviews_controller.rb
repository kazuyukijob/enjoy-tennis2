class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @tennis_court = TennisCourt.find(params[:format])
  end

  def index
    @tennis = TennisCourt.find(params[:format])
    @reviews = @tennis.reviews
  end

  def show
    @review = Review.new
    @reviews = Review.all
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    # byebug
    if  @review.save
      #セーブされた時点ではid発行されてないので投稿内容からfindしてidを取得（タイトル、本文、画像どれか一つ探す）
      review = Review.find_by(review_title: @review.review_title)
      #取得したidからshow画面へ遷移
      redirect_to review_path(review)
    else
      render :new
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "successfully"
      redirect_to review_path(@review.id)
    else
      render :edit
    end
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
