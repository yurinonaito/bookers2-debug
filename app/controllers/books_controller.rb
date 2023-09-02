class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
    @user = @book.user
    @books = Book.new
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @book.user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      flash.now[:notice]="can't be blank"
      render :index
    end
  end

  def edit
     book = Book.find(params[:id])
  unless book.user.id == current_user.id
         redirect_to books_path
  end
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:notice]="error"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end