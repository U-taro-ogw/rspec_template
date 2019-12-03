module ApiRequestable
  extend ActiveSupport::Concern

  def fetch_programming_languages
    HttpRequests::BookTextApi::Client.new.fetch_index
  end
end