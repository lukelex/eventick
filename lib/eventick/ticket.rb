class Eventick::Ticket
  attr_accessor :id, :name

  def initialize(args={})
    args.each do |key, value|
      self.public_send("#{key}=", value)
    end
  end
end
