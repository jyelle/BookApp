class BooksController < ApplicationController
	def index
    	if params[:q]
      		@books = Book.search(params[:q])
    	else
      		@books = Book.all
    	end
  	end

  	def new
  		@book = Book.new
  		@book.notes.build
  		@book.favequotes.build
  		@book.ratings.build
  		@book.lityears.build
  	end

  	def create
    @book = Book.new safe_book_params
    @book.notes.last.user_id = current_user.id
    @book.ratings.last.user_id = current_user.id
    @book.favequotes.last.user_id = current_user.id
    @book.lityears.last.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      flash_first_error(@book)
      redirect_to new_book_path
    end		
	end		

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path
  end

	def show
		@book = Book.find(params[:id])
    @lityear = @book.lityears.find_by(user_id: current_user.id)
    @note = @book.notes.find_by(user_id: current_user.id)
    @rating = @book.ratings.find_by(user_id: current_user.id)
    @favequote = @book.favequotes.find_by(user_id: current_user.id)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
    @book = Book.find(params[:id])
    if @book.update safe_book_params
      redirect_to book_path(@book)
    else
      flash_first_error(@book)
      redirect_to edit_book_path(@book)
    end		
	end

private
  def safe_book_params
    params.require(:book).permit(:title, :author, :content, :quotation, :year_read, :stars, notes_attributes: [:content], favequotes_attributes: [:quotation], lityears_attributes: [:year_read], ratings_attributes: [:stars])
  end

  def flash_first_error(book)
    flash[:error] = book.errors.first
  end

end
