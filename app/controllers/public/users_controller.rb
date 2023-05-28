class Public::UsersController < ApplicationController
   before_action :ensure_current_user, {only: [:edit, :update]}
   before_action :ensure_guest_user, only: [:edit]

  def show
    #@user = current_user
    @user = User.find(params[:id])
  end

  def edit
    #@user = current_user
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "登録情報を変更しました"
      redirect_to user_path
    else
       render :edit #and return
    end
  end

  private

	def user_params
  	params.require(:user).permit(:email, :family_name, :personal_name, :nickname, :profile_image)
  end

  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
