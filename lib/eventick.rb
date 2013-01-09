require 'net/http'
require 'json'
require 'cgi'

require "eventick/version"

require 'eventick/auth'
require 'eventick/event'
require 'eventick/attendee'
require 'eventick/ticket'

module Eventick
  def self.config(&block)
    @auth = Eventick::Auth.new &block
  end

  def self.request(uri, params={})
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    response = http.start do |http|
      path = with_params uri.request_uri, params
      http.request Net::HTTP::Get.new(path)
    end

    return {} unless response.is_a? Net::HTTPSuccess
    # return response.body unless block_given?
    # yield JSON.parse(response.body)
    JSON.parse(response.body)
  end

  def self.auth_token
    @auth.token
  end

  def self.auth
    @auth
  end

private
  def self.with_params(url, params)
    url + "?" + params.map {|k,v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }.join("&")
  end
end
