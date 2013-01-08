require_relative '../test_helper'

describe Eventick::Event do
  let (:event) { Eventick::Event.new }

  describe 'checking method initialization' do
    fields = [:id, :start_at, :title, :tickets]

    it ('cheking instance variables') do
      fields.each do |field|
        event.must_respond_to field
      end
    end
  end
end