module HttpRequests
  class ApiClientBase
    attr_accessor :api_url,
                  :header,
                  :path

    def initialize
      self.header = { 'Content-Type' => 'application/json' }
    end

    def generate_uri
      URI.parse(api_url + path)
    end

    def get_request(uri)
      Net::HTTP.new(uri.host, uri.port).get(uri.path, header)
    end
  end
end