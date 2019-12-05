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

    def create
      books = Book.bulk_insert(books_param[:books])
      response_created BookSerializer.new(books).serialized_json
    end

    def update
      book = Book.find_by(id: book_id_params)
      return response_not_found unless book

      book.update(book_param[:book])
      response_ok BookSerializer.new(book).serialized_json
    end

    def destroy
      book = Book.find_by(id: book_id_params)
      return response_not_found unless book

      book.destroy
      response_ok BookSerializer.new(book).serialized_json
    end

    def delete_selected
      books = Book.where(id: book_ids_param)
      books.destroy_all
      response_ok BookSerializer.new(books).serialized_json
    end

    def fetch_api
      books_text = fetch_book_text
      # merge_text(books_text)

      # response_ok BookSerializer.new(books).serialized_json

      render status: 200, json: { data: merge_text(books_text) }
    end

    private

    def book_id_params
      params[:id]
    end

    def book_param
      params.permit(book: %i[title author price])
    end

    def books_param
      params.permit(books: %i[title author price])
    end

    def book_ids_param
      params[:ids]
    end

    def merge_text(books_text)
      books = Book.all
      books.map { |book|  book.attributes.merge( books_text.find { |text| text[:id] == book.id } ) }
    end
  end
end
