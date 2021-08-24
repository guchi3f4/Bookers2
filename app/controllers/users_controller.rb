class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def edit
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(params_user)
      redirect_to user_path(@user), notice: "You have updated user successfully."
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
    @i = 6

    @today_book = @books.where(created_at: Time.zone.now.all_day).count
    @yesterday_book = @books.where(created_at: 1.day.ago.all_day).count
    @this_week = @books.where(created_at: Date.today.ago(6.days)..Time.current).count
    @last_week = @books.where(created_at: Date.today.ago(13.days)..Date.today.ago(6.days)).count

    unless @user == current_user
      other_user_rooms = @user.entries.pluck(:room_id)
      @entry = Entry.find_by(user_id: current_user, room_id: other_user_rooms)
      if @entry.present?
        @room = @entry.room
      else
        @new_room = Room.new
        @new_entry = Entry.new
      end
    end
  end

  def following
    @users  = User.find(params[:id]).following
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  def search
    @user  = User.find(params[:id])
    @books_count =@user.books.where(created_at: params[:content].in_time_zone.all_day).count
    render "books_count"
  end



  private

  def params_user
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
