module Mollie
  class IdealResponse
    
    attr_accessor :payload
    
    def initialize(xml_response)
      self.payload = xml_response.response
      raise Mollie::IdealException.new(errorcode, errormessage) if error_occured?
    end
    
    private 
    def error_occured?
      payload.key?(:item) and payload.item.key?(:errorcode)
    end
    
    def errorcode
      payload.item.errorcode.to_i if error_occured?
    end
    
    def errormessage
      payload.item.message if error_occured?
    end
    
  end
end