require_relative '../test_helper'

describe Eventick::Ticket do
  let (:ticket) { Eventick::Ticket.new }

  describe 'checking method initialization' do
    fields = [:id, :type]

    it ('checking instance variables') do
      fields.each do |field|
        ticket.must_respond_to field
      end
    end
  end

  describe 'retrieving tickets' do
    before do
      fake_get_url Eventick::Auth::URI, auth_response, auth_params
      fake_get_url Eventick::Event::URI, events_response, events_params
    end

    it 'all' do
      event = Eventick::Event.all.first
      event.tickets.size.must_equal 2
    end
  end
end