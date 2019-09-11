class Api::BooksController < ApplicationController
  def index
    books = Book.all.map(&:to_json)
    render json: { status: 200, books: books }
  end

  def show
    book = Book.find_by(id: book_id_params)
    return response_not_found unless book

    response_ok BookSerializer.new(book).serialized_json
  end

  private

  def book_id_params
    params[:id]
  end

  # def book_response(book)
  #   { book: book }.to_json
  # end
end
