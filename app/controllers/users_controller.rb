class UsersController < ApplicationController
  before_action :is_matching_login_user, only:[:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
