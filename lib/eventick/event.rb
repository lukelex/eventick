require_relative 'base'

module Eventick
  class Event < Base
    resource "events/:id"

    attr_accessor :id, :start_at, :title, :tickets, :venue, :slug
    attr_reader :attendees, :all

    # constructors
    def initialize(args={})
      links = args.delete('links')
      args.each do |key, value|
        self.public_send("#{key}=", value)
      end

      self.tickets = links['tickets'].map { |o| Ticket.new(o) } if links
    end

    # class methods
    def self.all
      events_response = Eventick.get path
      events_response['events'].map { |event_response| self.new event_response }
    end

    # class methods
    def self.find_by_id(id)
      events_response = Eventick.get path({ id: id })
      params = events_response['events'].first
      self.new params unless params.empty?
    end

    # instance methods
    def attendees(reload = false)
      if reload || @attendees.nil?
        @attendees = Attendee.all self
      end

      @attendees
    end

    private
    def self.auth_token
      { :auth_token => Eventick.auth_token }
    end
  end
end
