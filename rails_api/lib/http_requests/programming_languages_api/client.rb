module HttpRequests
  module ProgrammingLanguagesApi
    class Client < ApiClientBase
      def initialize
        self.api_url = ENV['DUMMY_API_URL']
        self.path = '/programming_languages'
      end

      def fetch_index
        uri = generate_uri
        response = get_request(uri)
        raise StandardError unless response.code.to_i == 200

        JSON.parse(response.body)["programming_languages"].map(&:with_indifferent_access)
      end
    end
  end
end
