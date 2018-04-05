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

    def most_confident_text
      if count == 1
        @body[:card][:answers][0][:text]
      else
        @body.sort { |a, b|
          b[:confidence] <=> a[:confidence]
        }[0][:card][:answers][0][:text]
      end
    end
  end
end
