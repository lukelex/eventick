class Eventick::Event
  URI = URI('http://eventick.com.br/api/v1/events.json')

  attr_accessor :id, :start_at, :title, :tickets
  attr_reader :attendees

  # constructors
  def initialize(args={})
    args.each do |key, value|
      self.public_send("#{key}=", value)
    end
  end

  # class methods
  def self.all
    events_response = Eventick.request URI, auth_token
    events_response.map { |event_response| self.new event_response }
  end

  # instance methods
  def attendees
    @attendees ||= Eventick::Attendee.get_by_event self
  end

private
  def self.auth_token
    { :auth_token => Eventick.auth_token }
  end
end