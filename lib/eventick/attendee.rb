class Eventick::Attendee
  URI = URI('http://eventick.com.br/api/v1/attendees.json')

  attr_accessor :id, :name, :search_index
  attr_accessor :code, :ticket_type, :checked_at

  def initialize(args={})
    args.each do |key, value|
      self.public_send("#{key}=", value)
    end
  end

  # class methods
  def self.get_by_event(event)
    attendees_response = Eventick.request URI, params(event)
    attendees_response.map { |attendee_response| self.new attendee_response }
  end

  def checkin
    Eventick::Checkin.create self
  end

private
  def self.params(event)
    { :auth_token => Eventick.auth_token, :event_id => event.id }
  end
end