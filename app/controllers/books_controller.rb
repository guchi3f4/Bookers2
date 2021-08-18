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
    if params[:sort] == "favorite_desc"
      @books = Book.all.sort{|a,b|
        b.favorites.where(created_at: set_week).size <=>
        a.favorites.where(created_at: set_week).size
      }
    elsif params[:category]
      @books = Book.where(category: params[:category])
    elsif  params[:content]
      content = params[:content]
      @books = Book.where("title LIKE ? OR category LIKE ?", "%#{content}%","%#{content}%")
    else
       @books = Book.all.order(params[:sort])
    end
    # if params[:sort] == "evaluation_desc"
    #   @books = Book.order(evaluation: :DESC)
    # elsif params[:sort] == "favorite_desc"
    #   @books = Book.all.sort{|a,b|
    #     b.favorites.where(created_at: set_week).size <=>
    #     a.favorites.where(created_at: set_week).size
    #   }
    # elsif params[:category]
    #   @books = Book.where(category: params[:category]).order(title: :ASC)
    # elsif  params[:content]
    #   content = params[:content]
    #   @books = Book.where("title LIKE ? OR category LIKE ?", "%#{content}%","%#{content}%")
    # else
    #   @books = Book.order(id: :DESC)
    # end
  end

  def show
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      @book.book_count += 1
      @book.save
    end
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
    params.require(:book).permit(:title, :body, :evaluation, :category)
  end

  def set_week
    Time.current.ago(6.days)..Time.current
  end
end
