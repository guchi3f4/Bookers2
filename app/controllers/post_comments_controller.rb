class PostCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    post_comment = current_user.post_comments.new(book_params)
    post_comment.book_id = book.id
    post_comment.save
    redirect_to book_path(params[:book_id])
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
