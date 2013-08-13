require_relative '../test_helper'

module Eventick
  describe ParamsParser do
    describe '#perform' do
      it 'simple route' do
        parser = ParamsParser.new 'some_resource'
        parser.perform.must_equal 'some_resource'
      end

      it 'single param route' do
        parser = ParamsParser.new 'some_resource/:id', id: 50
        parser.perform.must_equal 'some_resource/50'
      end

      it 'double params route' do
        parser = ParamsParser.new(
          'some_resource/:id/something/:another_id',
          id: 50, another_id: 9
        )
        parser.perform.must_equal 'some_resource/50/something/9'
      end
    end
  end
end
