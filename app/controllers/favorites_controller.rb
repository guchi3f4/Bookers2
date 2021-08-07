class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorites = current_user.favorites.new
    favorites.book_id = book.id
    favorites.save
    if params[:link] == "1"
      redirect_to book_path(params[:book_id])
    else
      redirect_to books_path
    end
  end

  def destroy
    current_user.favorites.find_by(book_id: params[:book_id]).destroy
    if params[:link] == "1"
      redirect_to book_path(params[:book_id])
    else
      redirect_to books_path
    end
  end
end