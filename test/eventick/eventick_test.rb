require_relative '../test_helper'

describe Eventick do
  describe 'checking method initialization' do
    it ('config') { Eventick.must_respond_to :config }
  end

  describe 'initializing the configuration' do
    Eventick.config do |eventick|
      eventick.email = 'jesus@eventick.com.br'
      eventick.password = '12345678'
    end
  end
end