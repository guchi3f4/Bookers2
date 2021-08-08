class UsersController < ApplicationController
    def edit
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to user_path(current_user)
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(params_user)
        redirect_to user_path(@user)
        flash[:notice] = "You have updated user successfully."
      else
        render :edit
      end
    end

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @books = @user.books
    end

    def following
      @users  = User.find(params[:id]).following
    end

    def followers
      @user  = User.find(params[:id])
      @users = @user.followers
    end

    private

    def params_user
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
