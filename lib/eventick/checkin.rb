class Eventick::Checkin
  URI = URI('http://eventick.com.br/api/v1/attendees/check_all.json')

  attr_accessor :attendee, :checkin_time

  def initialize(args={})
    self.attendee = args[:attendee]
    self.checkin_time = Time.now
  end

  def self.create(attendee)
    (self.new :attendee => attendee).save
  end

  def save
    checkin_response = Eventick.put URI, params
    self.attendee.checked_at = checkin_time
    self
  end

private
  def params
    {
      :attendees => [
        :id => self.attendee.id,
        :checked_at => self.checkin_time
      ]
    }
  end
end