class Api::BooksController < ApplicationController
  def index
    books = Book.all.map{ |book| book.attributes.to_json }
    render json: { status: 200, books: books }
  end
end
