module Eventick
  class Base
    def self.resource(res)
      @resource = res
    end

    def self.path(args={})
      if @resource
        path = translate(args)
        "#{ path }.json"
      else
        warn "The #{ self.name } class has not defined any resource path."
        raise
      end
    end

    def self.translate(args)
      last_resource_rexp = /\/:(.\w+)$/
      resource_keys = /(?<=:)(.\w+)/

      one = @resource.gsub(last_resource_rexp).count == 0

      if args.empty?
        matched = @resource.gsub(last_resource_rexp, "")
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
