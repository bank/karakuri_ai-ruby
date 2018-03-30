require 'json'
require 'net/http'
require 'uri'

module KarakuriAi
  class Client
    def initialize
      @api_key = KarakuriAi.config.api_key
      uri = URI.parse("https://#{KarakuriAi.config.account}.karakuri.ai")
      @client = Net::HTTP.new(uri.host, uri.port)
      @client.use_ssl = true
    end

    def reply(query: nil, count: 1)
      request = @client.post(
        '/api/ext/reply',
        {
          query: query,
          count: count
        }.to_json,
        header
      )
      Reply.new(json: request.body, count: count)
    end

    private

    def header
      @header ||= {
        'Content-Type'  => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
    end
  end
end
