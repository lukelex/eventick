require_relative '../test_helper'

describe Eventick::Event do
  let (:event) { Eventick::Event.new }
  let (:auth_params) { { :user => 'dpoi2154wijdsk4fo65ow4o2pkd' } }

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
      fake_get_url Eventick::Event.path, events_response, auth_params
    end

    it 'all' do
      events = Eventick::Event.all
      events.size.must_equal 11
    end
  end

  describe 'retrieving one event' do
    before do
      fake_get_url Eventick::Event.resource, events_response, auth_params
    end

  end

end
