module Mollie
  class Ideal
    include HTTParty
    format :xml
    base_uri "https://secure.mollie.nl"
    
    class << self
    
      attr_accessor :testmode
      
      def banklist
        options = {:a => "banklist"}
        options.merge!({:testmode=>true}) if testmode
        payload = send_command(options).payload
        
        if payload.bank.class.name == "Mash"
          #in testmode there is  only 1 bank. This is not wrapped in an Array.
          return [payload.bank]
        elsif payload.bank.class.name == "Array"
          #in production mode the list is an Array.
          payload.bank
        end
      end
      
      def prepare_payment(bank_id,amount,description,return_url,callback_url)
        
        #callback_url is being called by mollie in the background. They add an GET parameter :transaction_id
        #return_url is used after the payment is done. The redirection also adds the :transaction_id as an GET parameter
        options = {
          :a => "fetch",
          :bank_id=>bank_id,
          :description=>description,
          :amount=>amount,
          :reporturl=>callback_url,
          :returnurl=>return_url,
          :partnerid=>Mollie.partner_id
        }
        
        options.merge!({:testmode=>true}) if testmode
        send_command(options).payload.order
      end
      
      def check_order(transaction_id)
        options = {
          :a => "check",
          :partnerid=>Mollie.partner_id,
          :transaction_id => transaction_id
        }
        options.merge!({:testmode=>true}) if testmode
        send_command(options).payload.order
      end
      
      
      def send_command(options)
        IdealResponse.new(Mash.new( get("/xml/ideal", :query=> options, :format=>:xml) ))
      end
      
    end
    
  end
end