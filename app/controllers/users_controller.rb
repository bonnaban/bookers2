class UsersController < ApplicationController
  def index
    @book = Book.new
    @books = Book.page(params[:page])
    @user = current_user
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @user2 = current_user
    @book = @user.books
    @book2 = Book.new
    @book3 = Book.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      @user = current_user.id
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
    flash[:notice] = 'You have updated user successfully.'
    redirect_to user_path(@user)
    else
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
