require_relative 'base'

module Eventick
  class Auth < Base
  resource "tokens"

  attr_accessor :email
  attr_writer :password

  def initialize(&block)
    block.call self if block_given?
  end

  def token
    @token ||= (get)['token']
  end

  def authenticated?
    !!@token
  end

private
    def get
      @token = nil
      path = Eventick.api_path self.class.path
      method = Net::HTTP::Get.new(path)
      method.basic_auth @email, @password

      Eventick.request(method)
    end
  end
end
