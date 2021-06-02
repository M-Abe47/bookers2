class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    if comment.save
      redirect_to request.referer
    else
      flash[:notice] = "Comments cannot be left blank."
      redirect_to request.referer
    end
  end

  def destroy
    book_comment = BookComment.find(params[:book_id])
    if book_comment.user != current_user
      redirect_to request.referer
    end
    book_comment.destroy
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
