class Admin::TennisCourtsController < ApplicationController
  def new
    @tennis_court = TennisCourt.new
  end
  def index
    @tennis_courts = TennisCourt.all
  end

  def edit
    @tennis_court = TennisCourt.find(params[:id])
  end

  def create
    @tennis_court = TennisCourt.new(tennis_court_params)
    @tennis_court.save
    redirect_to  admin_tennis_courts_path(@tennis_court)
  end

  def update
    @tennis_court = TennisCourt.find(params[:id])
    if @tennis_court.update(tennis_court_params)
    flash[:notice] = "successfully"
    redirect_to admin_tennis_courts_path(@tennis_court.id)
    else
    render :edit
    end
  end

  def destroy
    @tennis_court = TennisCourt.find(params[:id])  # データ（レコード）を1件取得
    @tennis_court.destroy  # データ（レコード）を削除@reviewを消去
    redirect_to admin_tennis_courts_path(@tennis_court.id)  # 投稿一覧画面へリダイレクト
  end

    private
  # ストロングパラメータ
  def tennis_court_params
    params.require(:tennis_court).permit(:name, :explanation, :address, :image)
  end

end
