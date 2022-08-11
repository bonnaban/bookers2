class BooksController < ApplicationController
  def new
  end

  def index
    @book = Book.new
    @books = Book.page(params[:page])
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book2 = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])

    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id

    if @book.update(book_params)
    flash[:notice] = 'You have updated book successfully.'
    redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      @book3 = Book.page(params[:page])
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
