class BooksController < ApplicationController
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  
  def new
    @book = Book.new()
  end
  
  def create 
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else 
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @newbook = Book.new()
    @book_comment = BookComment.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end
  
  def edit 
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully editted"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "Edit was unsuccessful"
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully destroyed"
      redirect_to books_path
    else
      flash[:notice] = "Deletion was unsuccessful"
      render :index
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = User.find(book.user.id)
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
