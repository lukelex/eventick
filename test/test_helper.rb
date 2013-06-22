require 'minitest/spec'
require 'minitest/autorun'
require 'turn'
require 'fakeweb'
require File.expand_path('../../lib/eventick.rb', __FILE__)

module TestHelpers
  BASE_PATH = File.expand_path("../fixtures", __FILE__)

  def fetch_fixture_path(path)
    File.join(BASE_PATH, path)
  end

  def auth_url(path, auth)
     if !auth.empty? && auth[:user]
         pass = ":#{ CGI.escape(auth[:password].to_s) }" if auth[:password]
        auth_str = "#{ CGI.escape(auth[:user].to_s) }#{ pass }@"
    end

     "https://#{ auth_str }www.eventick.com.br/api/v1/#{ path }"
  end

  def fake_get_url(path, response, auth={}, params={})
    url = auth_url(path, auth)
    url = with_params(url, params)
    FakeWeb.register_uri(:get, url, :body => response)
  end

  def fake_put_url(path, response, auth={})
    url = auth_url(path, auth)
    FakeWeb.register_uri(:put, url, :body => response)
  end

  def with_params(url, params )
    escape_pair = Proc.new {|k,v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }
    to_query = "?" + params.map(&escape_pair).join("&") unless params.empty?
    "#{ url }#{ to_query }"
  end
end

class MiniTest::Spec
  include TestHelpers

  let (:attendees_params) { { :auth_token => 'dpoi2154wijdsk4fo65ow4o2pkd', :event_id => '11' } }

  let (:auth_response) { fetch_fixture_path('auth.json') }
  let (:events_response) { fetch_fixture_path('events.json') }
  let (:attendees_response) { fetch_fixture_path('attendees.json') }
  let (:checkin_response) { fetch_fixture_path('checkin.json') }

  before do
    FakeWeb.allow_net_connect = false

    register_malformed_token_request
    register_token_request

    Eventick.config do |eventick|
      eventick.email = 'testing@eventick.com.br'
      eventick.password = '12345678'
    end

    Eventick.auth_token
  end

private
  def register_malformed_token_request
    FakeWeb.register_uri(
      :get,
      'https://www.eventick.com.br/api/v1/tokens.json',
      :body => 'The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.',
      :status => ['401', 'Not Authorized']
    )
  end

  def register_token_request
    fake_get_url Eventick::Auth.path, auth_response, { :user => 'testing@eventick.com.br', :password => 12345678 }
  end

end
