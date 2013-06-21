require_relative '../test_helper'

describe Eventick::Auth do
  let (:auth) { Eventick.auth }
  let (:auth_params) { { :user => 'testing@eventick.com.br', :password => 12345678 } }

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
      fake_get_url Eventick::Auth.path, auth_response, auth_params
    end

    it 'with valid credentials' do
      auth.token.must_equal events_params[:auth_token]
    end

    it 'with invalid credentials' do
      Eventick.config {}
      auth.token.must_be_nil
    end
  end
end
