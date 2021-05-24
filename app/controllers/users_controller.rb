class UsersController < ApplicationController
  def index
    @users =User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
		@book = Book.new(book_params)
    @book.user_id = current_user.id
	  @book.save
	  redirect_to  books_path
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to book_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def user_params
      params.require(:user).permit(:name,:profile_image,:introduction)
    end

end