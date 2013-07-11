require_relative '../test_helper'

module Eventick
  describe Attendee do
    let (:attendee) { Attendee.new }

    describe 'checking method initialization' do
      fields = [:id, :name, :search_index, :code, :ticket_type, :checked_at]

      it 'checking instance variables' do
        fields.each do |field|
          attendee.must_respond_to field
        end
      end
    end

    describe 'retrieving attendees' do
      let(:events) { { id: 24 }}
      let(:attendees) { { event_id: 24 } }
      let(:attendee) { { event_id: 24, id: 145 } }

      before do
        fake_get_url Event.path(events), find_event_response, auth_params
        fake_get_url Attendee.path(attendees), attendees_response, auth_params
        fake_get_url Attendee.path(attendee), find_attendee_response, auth_params
      end

      it 'all from event' do
        event = Event.find_by_id(events[:id])
        event.attendees.size.must_equal 10
      end

      it 'all' do
        attendees = Attendee.all(events[:id])
        attendees.size.must_equal 10
      end

      it 'find one' do
        event_id, attendee_id =  attendee[:event_id], attendee[:id]
        attendee = Attendee.find_by_id(event_id, attendee_id)
        attendee.must_be_kind_of Attendee
      end
    end
  end
end
