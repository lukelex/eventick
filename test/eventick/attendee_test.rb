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
    let (:auth_response) { fetch_fixture_path('auth.json') }
    let (:events_response) { fetch_fixture_path('events.json') }
    let (:attendees_response) { fetch_fixture_path('attendees.json') }

    before do
      fake_get_url Eventick::Auth::URI, auth_response, :email => 'jesus@eventick.com.br', :password => 12345678
      fake_get_url Eventick::Event::URI, events_response, :auth_token => 'dpoi2154wijdsk4fo65ow4o2pkd'
      fake_get_url Eventick::Attendee::URI, attendees_response, :auth_token => 'dpoi2154wijdsk4fo65ow4o2pkd', :event_id => '11'
    end

    it 'all' do
      event = Eventick::Event.all.first
      event.attendees.size.must_equal 2
    end
  end
end