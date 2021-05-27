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
    if @user != current_user
      redirect_to "/books/#{current_user.id}"
    end
  end

  def create
		@book = Book.new(book_params)
    @book.user_id = current_user.id
	  @book.save
	  redirect_to books_path
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have created book successfully."
      redirect_to user_path(user_id: params[:id])
    else
      render :edit
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def user_params
      params.require(:user).permit(:name,:profile_image,:introduction)
    end

end