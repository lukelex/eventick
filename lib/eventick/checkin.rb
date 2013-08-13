module Eventick
  class Checkin < Base
    resource 'events/:event_id/attendees/:code'

    attr_accessor :attendee, :checkin_time

    def initialize(args={})
      self.attendee = args[:attendee]
      self.checkin_time = Time.now
    end

    def self.create(attendee)
      (self.new :attendee => attendee).save
    end

    def self.all(event,attendees)
      params = params(event)
      checkin_time = Time.now
      attendees.each{ |a| a.checkin_at = checkin_time }
      atts = attendees.map{ |a| a.to_json }.join(",")
      data = "{ 'attendees': [#{ atts }]  }"
      checkin_response = Eventick.put path(params), data
      true
    end

    def save
      params = self.attendee.to_param
      checkin_response = Eventick.put self.class.path(params), { checked_at: checkin_time}
      self.attendee.checked_at = checkin_time
      true
    end

private
    def self.params(event, attendee_code = nil)
      event_id = event
      event_id = event.id if event.is_a? Event
      params = { event_id: event_id, code: "check_all"}
      params[:code] = attendee_code if attendee_code
      params
    end
  end
end
