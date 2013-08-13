require_relative '../test_helper'

module Eventick
  describe Base do
    describe '.resource' do
      it 'should not allow an empty resource' do
        lambda {Base.resource nil}.must_raise InvalidResource
      end

      it 'should not allow a resource with white spaces' do
        lambda {Base.resource 'with spaces'}.must_raise InvalidResource
      end
    end

    describe '.path' do
      it 'with blank args' do
        Base.resource 'some_resource_page'
        Base.path.must_equal 'some_resource_page.json'
      end

      it 'single resource path without param' do
        Base.resource 'some_route/:id'
        Base.path.must_equal 'some_route.json'
      end

      it 'single resource path with param' do
        Base.resource 'some_route/:id'
        (Base.path id: 13).must_equal 'some_route/13.json'
      end
    end
  end
end
