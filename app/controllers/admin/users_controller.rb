class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "You have updated user successfully."
    else
      # render "show"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :family_name, :personal_name, :nickname)
  end
end
