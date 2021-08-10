class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorites = current_user.favorites.new
    favorites.book_id = @book.id
    favorites.save

  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorites.find_by(book_id: @book).destroy

  end
end