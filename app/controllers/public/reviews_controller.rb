class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @tennis_court = TennisCourt.find(params[:format])
  end

  def index
    @tennis_court = TennisCourt.find(params[:tennis_court_id])
    @reviews = @tennis_court.reviews
    @comment = Comment.new
  end

  def show
    @review = Review.new
    @reviews = Review.all
  end

  def myreview
    @reviews = Review.where(user_id: params[:user_id])
    #@reviews = Review.all
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.score = Language.get_data(review_params[:review_body])  #この行を追加
    @review.user_id = current_user.id
    if  @review.save
      redirect_to tennis_court_reviews_path(params[:review][:tennis_court_id].to_i)
    else
      render :new
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "successfully"
      redirect_to tennis_court_reviews_path(@review.tennis_court)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])  # データ（レコード）を1件取得
    @review.destroy  # データ（レコード）を削除@reviewを消去
    redirect_to tennis_court_reviews_path(@review.tennis_court_id)  # 投稿一覧画面へリダイレクト
  end

    private
  # ストロングパラメータ
  def review_params
    params.require(:review).permit(:review_title, :review_body, :image, :tennis_court_id)
  end
end
