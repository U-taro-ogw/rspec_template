module ApiRequestable
  extend ActiveSupport::Concern

  def fetch_book_text
    HttpRequests::BookTextApi::Client.new.fetch_index
  end
end