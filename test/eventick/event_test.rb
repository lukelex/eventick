require_relative '../test_helper'

describe Eventick::Event do
  let (:fields) { [:id, :start_at, :title, :tickets, :venue, :slug] }

  describe 'checking method initialization' do
    let (:event) { Eventick::Event.new }

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
    let(:params) { { id: 24 }}
    let(:event) {  Eventick::Event.find_by_id params[:event_id] }

    before do
      fake_get_url Eventick::Event.path(params), find_event_response, auth_params
    end

     it 'should be an Event object' do
      event.must_be_kind_of Eventick::Event
    end

    it 'cheking for required fields' do
      fields.each do |field|
        event.send(field).wont_be_nil
      end
    end
  end

end
