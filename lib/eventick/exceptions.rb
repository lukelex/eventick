module Eventick
  class EventickError < StandardError ; end

  class InvalidResource < EventickError ; end
  class UnmatchableParams < EventickError ; end
end
