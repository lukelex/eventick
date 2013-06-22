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
        if args.empty?
            path = @resource.gsub(/\/:(.\w)/, "")
        end
        path
    end

  end
end
