module Eventick
  class Base
    def self.resource(resource)
      if not resource
        raise InvalidResource, "The #{ self.name } class has not defined any resource path."
      elsif resource.include? ' '
        raise InvalidResource, 'No spaces allowed on a resource'
      end

      @resource = resource
    end

    def self.path(args={})
      path = translate(args)
      "#{ path }.json"
    end

private
    def self.translate(args)
      last_resource_regex = /\/:(.\w+)$/
      resource_keys = /(?<=:)(.\w+)/

      if args.empty?
        matched = @resource.gsub(last_resource_regex, "")
      else
        s_args = Hash[args.map{ |k, v| [k.to_s, v] }]
        matched = @resource.gsub(resource_keys, s_args)
        matched.gsub!(/:/ , "")
        matched.gsub!(/\/$/ , "")
      end

      remaining = matched.gsub(resource_keys).count

      if remaining != 0
        warn "Missing arguments for #{ self.name } class resource path: #{ matched }."
        raise
      end

      matched
    end
  end
end
