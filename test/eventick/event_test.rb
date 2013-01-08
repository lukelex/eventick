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
    let (:events_response) { fetch_fixture_path('events.json') }

    before do
      fake_get_url Eventick::Event::URI, events_response, :auth_token => 'dpoi2154wijdsk4fo65ow4o2pkd'
    end

    it 'all' do
      events = Eventick::Event.all
      events.size.must_equal 2
    end
  end
end