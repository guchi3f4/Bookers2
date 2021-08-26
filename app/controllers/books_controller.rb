class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.new(params_book)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] = "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
  end

  def update
    if @book.update(params_book)
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def index
    @book = Book.new
    #ソート機能
    if params[:sort] == "favorite_desc"
      @books = Book.all.sort{|a,b|
        b.favorites.where(created_at: set_week).size <=>
        a.favorites.where(created_at: set_week).size
      }
    elsif params[:category]
      @books = Book.where(category: params[:category])
    elsif params[:content]
      content = params[:content]
      @books = Book.where("title LIKE ? OR category LIKE ?", "%#{content}%","%#{content}%")
    elsif params[:sort].present?
      @books = Book.all.order(params[:sort])
    else
      @books = Book.all.order(id: 'DESC')
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    unless @book.user_id == current_user.id
      @book.book_count += 1
      @book.save
    end
    @post_comment = PostComment.new

    unless @user == current_user
      other_user_rooms = @user.entries.pluck(:room_id)
      @entry = Entry.find_by(user_id: current_user, room_id: other_user_rooms)
      if @entry.present?
        @room = @entry.room
      else
        @new_room = Room.new
      end
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def params_book
    params.require(:book).permit(:title, :body, :evaluation, :category)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def set_week
    Time.current.ago(6.days)..Time.current
  end
end
