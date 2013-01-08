module Eventick
  class Auth
    URL = 'http://eventick.com.br/api/v1/tokens.json'

    attr_accessor :email
    attr_writer :password

    def initialize(&block)
      block.call self if block_given?
    end
  end
end