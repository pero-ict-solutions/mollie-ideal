module Mollie
  class IdealException < Exception
    attr_accessor :errorcode, :message
    def initialize(errorcode, message="")
      self.errorcode = errorcode
      self.message = message
    end
  end
end