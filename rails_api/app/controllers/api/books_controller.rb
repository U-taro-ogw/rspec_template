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
<<<<<<< HEAD
      uri = URI.parse(ENV["DUMMY_API_URL"] + '/programming_languages')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme === "https"

      headers = { "Content-Type" => "application/json" }
      response = http.get(uri.path, headers)

      p response.code # status code
      p response.body # response body
=======
      get_programming_languages
>>>>>>> f8077575f631551a89f9176720748bb103bc7396
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
  end
end