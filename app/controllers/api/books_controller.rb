class Api::BooksController < ApplicationController
  def index
    render json: { hoge: 'fuga' }
  end
end
