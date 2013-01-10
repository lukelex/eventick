require_relative '../test_helper'

describe Eventick::Checkin do
  let (:checkin) { Eventick::Checkin.new }

  describe 'checking method initialization' do
    it ('checking instance variables') do
      checkin.must_respond_to :attendee
    end
  end

  describe 'checkin attendees' do
    before do
      fake_get_url Eventick::Auth::URI, auth_response, auth_params
      fake_get_url Eventick::Event::URI, events_response, events_params
      fake_get_url Eventick::Attendee::URI, attendees_response, attendees_params
      fake_put_url Eventick::Checkin::URI, checkin_response
    end

    it 'just one' do
      event = Eventick::Event.all.first
      attendee = event.attendees.first
      checkin_obj = attendee.checkin
      checkin_obj.must_be_instance_of Eventick::Checkin
      attendee.checked_at.must_equal checkin_obj.checkin_time
    end
  end
end