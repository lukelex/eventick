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

  describe 'retrieving events' do
    before do
      fake_get_url Eventick::Event::URI, events_response, events_params
    end

    it 'all' do
      events = Eventick::Event.all
      events.size.must_equal 2
    end
  end
end