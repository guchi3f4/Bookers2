class BooksController < ApplicationController
  def new

  end

  def create
    @book = Book.new(params_book)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def edit

  end
  def update

  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    book = Book.find(params[:id])
    @user = book.user
    @book = Book.new
    @user_book = Book.find(params[:id])
  end

  def destroy

  end

  private

  def params_book
    params.require(:book).permit(:title, :body)
  end
end
