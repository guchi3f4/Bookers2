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

    @userEntry = Entry.where(user_id: @user.id)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |us|
          if cu.room_id == us.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
    end
    unless @isRoom
      @room = Room.new
      @entry = Entry.new
    end
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
