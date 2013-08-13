module Eventick
  class ParamsParser
    RESOURCE_KEYS = /(?<=:)(.\w+)/
    LAST_RESOURCE_REGEX = /\/:(.\w+)$/

    def initialize(resource, params={})
      @resource = resource
      @params = params

      def @params.with_stringified_keys
        Hash[self.map{ |k, v| [k.to_s, v] }]
      end
    end

    def perform
      if missing_arguments
        raise UnmatchableParams, "Missing arguments: #{missing_arguments}."
      end

      if @params.empty?
        @resource.gsub(LAST_RESOURCE_REGEX, "")
      else
        stringified_hash = @params.with_stringified_keys
        replace_resource_fields stringified_hash
      end
    end

private
    def missing_arguments
      if (missing = (params_needed - available_params)).length > 1
        @missing_arguments = missing
      end
    end

    def params_needed
      @params_needed ||= @resource.scan(RESOURCE_KEYS).flatten
    end

    def available_params
      @params.with_stringified_keys.keys.flatten
    end

    def replace_resource_fields(stringified_hash)
      result = @resource.gsub(RESOURCE_KEYS, stringified_hash)
      result.gsub(/:/ , '').gsub(/\/$/ , '')
    end
  end
end
