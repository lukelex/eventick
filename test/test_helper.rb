require 'minitest/spec'
require 'minitest/autorun'
require 'turn'
require 'eventick'
require 'fakeweb'

module TestHelpers
  BASE_PATH = File.expand_path("../fixtures", __FILE__)

  def fetch_fixture_path(path)
    File.join(BASE_PATH, path)
  end

  def fake_get_url(uri, response, params={})
    uri += with_params(uri, params) unless params.empty?
    FakeWeb.register_uri(:get, uri, :body => response)
  end

  def with_params(url, params)
    url.request_uri + "?" + params.map {|k,v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }.join("&")
  end
end

class MiniTest::Spec
  include TestHelpers

  before do
    FakeWeb.allow_net_connect = false

    register_malformed_token_request

    Eventick.config do |eventick|
      eventick.email = 'jesus@eventick.com.br'
      eventick.password = '12345678'
    end
  end

private
  def register_malformed_token_request
    FakeWeb.register_uri(
      :get,
      'http://eventick.com.br/api/v1/tokens.json?email=&password=',
      :body => 'The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.',
      :status => ['404', 'Bad Request']
    )
  end
end