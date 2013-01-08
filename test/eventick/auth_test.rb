require_relative '../test_helper'

describe Eventick::Auth do
  let (:auth) { Eventick::Auth.new }

  describe 'checking method initialization' do
    it ('email') { auth.must_respond_to :email }
    it ('password') { auth.must_respond_to :password= }
    it ('password=') { auth.wont_respond_to :password }
  end

  it 'initializing the object' do
    new_auth = Eventick::Auth.new do |eventick|
      eventick.email = 'testing@eventick.com.br'
      eventick.password = '123456'
    end
    new_auth.email.must_equal 'testing@eventick.com.br'
  end
end