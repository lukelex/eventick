require_relative '../test_helper'

module Eventick
  describe Checkin do
    let (:checkin) { Checkin.new }

    describe 'checking method initialization' do
      it ('checking instance variables') do
        checkin.must_respond_to :attendee
      end
    end

    describe 'checkin attendees' do
      let(:attendee) { Attendee.find_by_id(24, 145 ) }

      before do
        fake_get_url Attendee.path({ event_id: 24, id: 145 } ), find_attendee_response, auth_params
        fake_put_url Checkin.path({ event_id: 24, code: "AD54E" } ), "{\"boo\": 1 }", auth_params
      end

      it 'just one' do
        checkin_obj = attendee.checkin
        checkin_obj.must_equal true
        attendee.checked_at.wont_be_nil
      end
    end
  end
end
