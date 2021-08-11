class BooksController < ApplicationController
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
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(params_book)
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def index
    @book = Book.new
    @books = Book.joins(:favorites).where(favorites: { created_at: Time.current.all_week }).group(:id).order('count(book_id) desc')
    #@books = Book.find(Favorite.group(:book_id).where( created_at: Time.current.all_week ).order('count(book_id) desc').pluck(:book_id))
  end

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new

    @userEntry = Entry.where(user_id: @book.user.id)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    unless @book.user.id == current_user.id
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

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def params_book
    params.require(:book).permit(:title, :body)
  end
end
