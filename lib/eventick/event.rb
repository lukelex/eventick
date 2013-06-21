require_relative 'base'

module Eventick
    class Event < Base
      resource "events"

      attr_accessor :id, :start_at, :title, :tickets
      attr_reader :attendees, :all

      # constructors
      def initialize(args={})
        args.each do |key, value|
          self.public_send("#{key}=", value)
        end
      end

      # class methods
      def self.all(reload = false)
        events_response = Eventick.get
        events_response.map { |event_response| self.new event_response }
      end

      # instance methods
      def attendees(reload = false)
        if reload || @attendees.nil?
            @attendees = Eventick::Attendee.get_by_event self
        end

        @attendees
      end

  private
    def self.auth_token
      { :auth_token => Eventick.auth_token }
    end
  end
end
