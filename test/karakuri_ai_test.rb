require "test_helper"

class KarakuriAiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::KarakuriAi::VERSION
  end

  def test_it_can_configure
    KarakuriAi.configure do |config|
      config.api_key = 'something'
      config.account = 'my-account'
    end

    assert_equal 'something', KarakuriAi.config.api_key
    assert_equal 'my-account', KarakuriAi.config.account
  end
end
