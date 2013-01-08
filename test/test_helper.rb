require 'minitest/spec'
require 'minitest/autorun'
require 'turn'
require 'eventick'
require 'fakeweb'

class MiniTest::Spec
  BASE_PATH = File.expand_path("../fixtures", __FILE__)

  def fetch_fixture_path(path)
    File.join(BASE_PATH, path)
  end

  def fake_get_url(uri, response)
    FakeWeb.register_uri(:get, uri, :body => response)
  end

  before do
    Eventick.config do |eventick|
      eventick.email = 'jesus@eventick.com.br'
      eventick.password = '12345678'
    end
  end
end