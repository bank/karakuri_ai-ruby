require 'test_helper'

class KarakuriAiClientTest < Minitest::Test
  def test_reply_returns_reply_object
    stub_request(
      :post,
      'https://test.karakuri.ai/api/ext/reply'
    ).with(
        body: "{\"query\":\"test\",\"count\":1}",
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer test',
          'Content-Type' => 'application/json',
          'User-Agent'=>'Ruby'
        }
    ).to_return(status: 200, body: <<~JSON, headers: {})
      {
        "card":{"answers":[{"actions":[],"text": "test message","_id": "da39a3ee5e6b"}],"_id":"da39a3ee5e6b","title":"test title"},
        "confidence":0.08
      }
    JSON

    client = KarakuriAi::Client.new(api_key: 'test', account: 'test')
    assert_equal KarakuriAi::Reply, client.reply(query: 'test').class
  end

  def test_reply_raises_exception_when_wrong_auth
    stub_request(
      :post,
      'https://test.karakuri.ai/api/ext/reply'
    ).to_return(status: 401)

    client = KarakuriAi::Client.new(api_key: '', account: 'test')
    assert_raises(Net::HTTPServerException) do
      client.reply(query: 'test')
    end
  end
end
