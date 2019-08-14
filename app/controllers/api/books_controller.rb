class Api::BooksController < ApplicationController
  def index
    books = Book.all.map(&:attributes).map(&:to_json)
    render json: { status: 200, books: books }
  end
end
