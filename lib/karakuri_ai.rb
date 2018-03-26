require "karakuri_ai/version"

module KarakuriAi
  def self.configure
    yield config
  end

  def self.config
    @_config ||= Config.new
  end

  class Config
    attr_accessor :api_key

    def initialize
      @api_key = nil
    end
  end
end
