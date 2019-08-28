class Api::BooksController < ApplicationController
  def index
    books = Book.all.map(&:to_json)
    render json: { status: 200, books: books }
  end

  def show
    book = Book.find_by(id: book_id_params)
    p book
    unless book
      render json: { status: 404, message: 'Not Found' }
    else
      render json: { status: 200, book: book.to_json }
    end
  end


  private

  def book_id_params
    params[:id]
  end
end
