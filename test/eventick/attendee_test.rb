require_relative '../test_helper'

describe Eventick::Attendee do
  let (:attendee) { Eventick::Attendee.new }

  describe 'checking method initialization' do
    fields = [:id, :name, :search_index, :code, :ticket_type, :checked_at]

    it ('checking instance variables') do
      fields.each do |field|
        attendee.must_respond_to field
      end
    end
  end

  describe 'retrieving attendees' do
    before do
      fake_get_url Eventick::Auth::URI, auth_response, auth_params
      fake_get_url Eventick::Event::URI, events_response, events_params
      fake_get_url Eventick::Attendee::URI, attendees_response, attendees_params
    end

    it 'all' do
      event = Eventick::Event.all.first
      event.attendees.size.must_equal 2
    end
  end
end