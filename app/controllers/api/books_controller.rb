module Api
  class BooksController < ApplicationController
    def index
      books = Book.all
      options = serialize_option(count: books.length)

      response_ok BookSerializer.new(books, options).serialized_json
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
  end
end
