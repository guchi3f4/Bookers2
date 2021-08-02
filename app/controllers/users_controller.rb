class UsersController < ApplicationController
    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(params_user)
        redirect_to user_path(@user)
      else
        render :edit
      end
    end

    def index
      @user = User.find(current_user.id)
      @book = Book.new
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @book = Book.new
      user = User.find(params[:id])
      @user_book = user.books
    end

    private

    def params_user
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
