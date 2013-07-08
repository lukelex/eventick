module Eventick
  class Attendee < Base
    resource "events/:event_id/attendees/:id"

    attr_accessor :id, :name
    attr_accessor :code, :ticket_type, :checked_at, :event_id

    def initialize(args={})
      args.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

  # class methods
  def self.all(event)
    params = params(event)
    attendees_response =  Eventick.get path(params)
    attendees = attendees_response['attendees'].map { |attendee_json| self.new attendee_json }
    attendees.each { |a| a.event_id = params[:event_id] }
  end

  def self.find_by_id(event, attendee_id)
    params = params(event, attendee_id)
    attendees_response =  Eventick.get path(params)
    params = attendees_response['attendees'].first
    attendee = self.new params unless params.empty?
    attendee.event_id = params[:event_id]
    attendee
  end

  def search_index
    self.name
  end

  def checkin
    Eventick::Checkin.create self
  end

  def to_param
     { event_id: self.event_id, code: self.code }
  end

  def to_json
      "{ 'id': #{ self.id }, 'checked_at': '#{ self.checkin_at }' }"
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
