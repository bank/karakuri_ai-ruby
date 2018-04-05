require 'test_helper'

class KarakuriAiReplyTest < Minitest::Test
  def test_reply_most_confident_text_return_confident_text
    response = <<~JSON
      [
        {
          "card":{"answers":[{"actions":[],"text": "not confident text","_id": "da39a3ee5e6b"}],"_id":"da39a3ee5e6b","title":"test title"},
          "confidence":0.1
        },
        {
          "card":{"answers":[{"actions":[],"text": "most confident text","_id": "356a192b79"}],"_id":"356a192b79","title":"test title"},
          "confidence":0.7
        }
      ]
    JSON
    reply = KarakuriAi::Reply.new(json: response, count: 2)

    assert_equal 'most confident text', reply.most_confident_text
  end
end
