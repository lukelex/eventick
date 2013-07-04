module Eventick
  class Attendee < Base
    resource "events/:event_id/attendees/:id"

    attr_accessor :id, :name
    attr_accessor :code, :ticket_type, :checked_at

    def initialize(args={})
      args.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

  # class methods
  def self.all(event)
    params = params(event)
    attendees_response =  Eventick.get path(params)
    attendees_response['attendees'].map { |attendee_json| self.new attendee_json }
  end

  def self.find_by_id(event, attendee_id)
    attendees_response =  Eventick.get path(params(event, attendee_id))
    params = attendees_response['attendees'].first
    self.new params unless params.empty?
  end

  def search_index
    self.name
  end

  def checkin
    Eventick::Checkin.create self
  end

private
    def self.params(event, attendee_id = nil)
      event_id = event
      event_id = event.id if event.is_a? Event
      params = { :event_id => event_id }
      params.merge!({ id: attendee_id }) if attendee_id
      params
    end
  end
end
