module ApiRequestable
  extend ActiveSupport::Concern

  def get_programming_languages
    HttpRequests::ProgrammingLanguagesApi::Client.new.fetch_index
  end
end