require "eventick/version"

require 'eventick/auth'

module Eventick
  def self.config(&block)
    @auth = Eventick::Auth.new &block
  end
end
