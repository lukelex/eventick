require_relative '../test_helper'

describe Eventick::Auth do
  let (:auth) { Eventick::Auth.new }

  describe 'checking method initialization' do
    it ('email') { auth.must_respond_to :email }
    it ('password=') { auth.must_respond_to :password= }
    it ('password') { auth.wont_respond_to :password }
    it ('token') { auth.must_respond_to :token }
    it ('token=') { auth.wont_respond_to :token= }
  end

  it 'initializing the object' do
    new_auth = Eventick::Auth.new do |eventick|
      eventick.email = 'testing@eventick.com.br'
      eventick.password = '123456'
    end
    new_auth.email.must_equal 'testing@eventick.com.br'
  end

  describe 'getting the api token' do
    before do
      FakeWeb.register_uri(
        :get,
        Eventick::Auth::URL,
        :body => '{ "token" : "dpoi2154wijdsk4fo65ow4o2pkd" }'
      )
    end

    it 'with valid credentials' do
      auth.token.must_equal 'dpoi2154wijdsk4fo65ow4o2pkd'
    end
  end
end