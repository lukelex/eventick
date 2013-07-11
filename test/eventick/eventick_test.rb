require_relative '../test_helper'

describe Eventick do
  describe 'checking method initialization' do
    it ('config') { Eventick.must_respond_to :config }
    it ('auth_token') { Eventick.must_respond_to :auth_token }

    it 'should have a version' do
      Eventick::VERSION.wont_be_nil
    end
  end
end
