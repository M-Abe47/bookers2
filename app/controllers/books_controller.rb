class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
  	@book = Book.new
  end

  def create
		@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully destroyed."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path  # 投稿一覧画面へリダイレクト
  end

  # 投稿データのストロングパラメータ
	private

  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end


end