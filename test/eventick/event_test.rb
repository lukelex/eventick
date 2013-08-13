require_relative '../test_helper'

module Eventick
  describe Event do
    let (:fields) { [:id, :start_at, :title, :tickets, :venue, :slug] }

    describe 'checking method initialization' do
      let (:event) { Event.new }

      it ('cheking instance variables') do
        fields.each do |field|
          event.must_respond_to field
        end
      end
    end

    describe 'retrieving events' do
      before do
        fake_get_url Event.path, events_response, auth_params
      end

      it 'all' do
        events = Event.all
        events.size.must_equal 11
      end
    end

    describe 'retrieving one event' do
      let(:params) { { id: 24 } }
      let(:event) { Event.find_by_id params[:id] }

      before do
        fake_get_url Event.path(params), find_event_response, auth_params
      end

      it 'should be an Event object' do
        event.must_be_kind_of Event
      end

      it 'checking for required fields' do
        fields.each do |field|
          event.public_send(field).wont_be_nil
        end
      end
    end
  end
end
