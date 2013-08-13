module Eventick
  class ParamsParser
    attr_reader :resource, :params

    RESOURCE_KEYS = /(?<=:)(.\w+)/

    def initialize(resource, params={})
      @resource = resource
      @params = params
    end

    def perform
      last_resource_regex = /\/:(.\w+)$/

      if params.empty?
        result = @resource.gsub(last_resource_regex, "")
      else
        s_args = Hash[params.map{ |k, v| [k.to_s, v] }]
        result = @resource.gsub(RESOURCE_KEYS, s_args)
        result.gsub!(/:/ , "")
        result.gsub!(/\/$/ , "")
      end

      # if self.number_of_params_needed != self.params_needed
      #   warn "Missing arguments for #{ self.name } class resource path: #{ matched }."
      #   raise
      # end

      result
    end

    def number_of_params_needed
      self.params_needed.count
    end

    def params_needed
      @resource.gsub(RESOURCE_KEYS)
    end
  end
end
