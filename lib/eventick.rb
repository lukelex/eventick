require 'net/http'
require 'json'
require 'cgi'
require 'openssl'

require_relative './eventick/version'
require_relative './eventick/auth'
require_relative './eventick/event'
require_relative './eventick/attendee'
require_relative './eventick/ticket'
require_relative './eventick/checkin'

module Eventick
  BASE_URL = 'www.eventick.com.br'
  BASE_PATH = '/api/v1/'

  def self.config(&block)
    @auth = Eventick::Auth.new &block
  end

  def self.get(resource, params={})
    path = api_path resource
    path = with_params path, params
    method = Net::HTTP::Get.new(path)

    request(method)
  end

  def self.put(resource, params={})
    path = api_path resource
    method = Net::HTTP::Put.new(path)
    method.set_form_data(params)
    method.content_type = 'application/json' if params.is_a? String

    request(method, params)
  end

  def self.request(method, params={})
    uri = URI("https://#{ BASE_URL }")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    if auth && auth.authenticated?
        method.basic_auth auth_token, ""
    end

    response = http.start do |http|
        http.request method
    end

    return { } unless response.is_a? Net::HTTPSuccess
    # return response.body unless block_given?
    # yield JSON.parse(response.body)
     JSON.parse(response.body)  unless response.body.nil?
  end

  def self.api_path(resource)
    BASE_PATH + resource
  end

  def self.auth_token
    @auth.token if @auth
  end

  def self.auth
    @auth
  end

private
   def self.with_params(url, params )
    escape_pair = Proc.new {|k,v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }
    to_query = "?" + params.map(&escape_pair).join("&") unless params.empty?
    "#{ url }#{ to_query }"
  end
end
