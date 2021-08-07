class PostCommentsController < ApplicationController
  def create
    @user_book = Book.find(params[:book_id])
    @post_comment = current_user.post_comments.new(book_params)
    @post_comment.book_id = @user_book.id
    if @post_comment.save
      redirect_to book_path(params[:book_id])
    else
      @user = Book.find(params[:book_id]).user
      @book = Book.new
      render "books/show"
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private
  def book_params
    params.require(:post_comment).permit(:comment)
  end
end
