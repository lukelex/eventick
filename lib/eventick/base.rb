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

    def self.path(params={})
      path = (ParamsParser.new @resource, params).perform
      "#{ path }.json"
    end
  end
end
