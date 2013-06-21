module Eventick
  class Base
    def self.resource(res)
        @resource = res
    end

    def self.path
        if @resource
            "#{ @resource }.json"
        else
            warn "The #{ self.name } class has not defined any resource path."
            raise
        end
    end
  end
end
