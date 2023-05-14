class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = user
  if @user.update(user_params)
    flash[:success] = "登録情報を変更しました"
    redirect_to users_path
  else
     render :edit #and return
  end

    private

	def user_params
  	params.require(:user).permit(:email, :family_name, :personal_name,:nickname)
  end

  end
end
