require 'net/http'
require 'json'

require "eventick/version"

require 'eventick/auth'

module Eventick
  def self.config(&block)
    @auth = Eventick::Auth.new &block
  end

  def self.request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    response = http.start do |http|
      http.request Net::HTTP::Get.new(uri.request_uri)
    end

    # return nil unless response.is_a?(Net::HTTPSuccess)
    # return response.body unless block_given?
    # yield JSON.parse(response.body)
    JSON.parse(response.body)
  end
end
