module HttpRequests
  module BookTextApi
    class Client < ApiClientBase
      def initialize
        self.api_url = ENV['DUMMY_API_URL']
        self.path = '/book_text'
      end

      def fetch_index
        uri = generate_uri
        response = get_request(uri)
        raise StandardError unless response.code.to_i == 200

        JSON.parse(response.body)["book_text"].map(&:with_indifferent_access)
      end
    end
  end
end
