require_relative '../test_helper'

module Eventick
  describe Auth do
    let (:auth) { Eventick.auth }

    describe 'checking method initialization' do
      it ('email') { auth.must_respond_to :email }
      it ('password=') { auth.must_respond_to :password= }
      it ('password') { auth.wont_respond_to :password }
      it ('token') { auth.must_respond_to :token }
      it ('token=') { auth.wont_respond_to :token= }
    end

    it 'initializing the object' do
      new_auth = Auth.new do |eventick|
        eventick.email = 'testing@eventick.com.br'
        eventick.password = '123456'
      end
      new_auth.email.must_equal 'testing@eventick.com.br'
    end

    describe 'getting the api token' do
      it 'with valid credentials' do
        puts auth_response
        auth.token.must_equal auth_params[:user]
      end

      it 'with invalid credentials' do
        Eventick.config {}
        auth.token.must_be_nil
      end
    end
  end
end
