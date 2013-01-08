class Eventick::Auth
  URI = URI('http://eventick.com.br/api/v1/tokens.json')

  attr_accessor :email
  attr_writer :password

  def initialize(&block)
    block.call self if block_given?
  end

  def token
    @token ||= (Eventick.request URI, params)['token']
  end

private
  def params
    { :email => @email, :password => @password }
  end
end