module Eventick
  class Auth
    URL = URI('http://eventick.com.br/api/v1/tokens.json')

    attr_accessor :email
    attr_writer :password

    def initialize(&block)
      block.call self if block_given?
    end

    def token
      @token ||= Eventick.request(URL)['token']
    end
  end
end