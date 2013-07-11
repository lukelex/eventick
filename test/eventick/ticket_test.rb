require_relative '../test_helper'

describe Eventick::Ticket do
  let(:args) { { id: 30, name: "name" } }
  let(:ticket) { Eventick::Ticket.new args }

  describe 'initialization with argument' do
    it "should assing the values" do
      args.keys.each do |field|
        ticket.send(field).must_equal args[field]
      end
    end
  end
end
