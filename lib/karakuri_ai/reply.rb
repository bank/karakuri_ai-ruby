require 'json'

module KarakuriAi
  class Reply
    attr_reader :body

    def initialize(json: nil, count: nil)
      @body = JSON.parse(json, symbolize_names: true)
      @count = count
    end

    def count
      @count
    end
  end
end
