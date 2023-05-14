class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def index
    @review = Review.new
    @reviews = Review.all
  end

  def show
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to reviews_path(@review)
  end

    private
  # ストロングパラメータ
  def review_params
    params.require(:review).permit(:review_title, :review_body, :image)
  end
end
