module ApiRequestable
  extend ActiveSupport::Concern

  def fetch_programming_languages
    HttpRequests::ProgrammingLanguagesApi::Client.new.fetch_index
  end
end