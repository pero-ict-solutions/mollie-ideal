require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mollie::Ideal do

  it "is in live mode by default" do
    Mollie::Ideal.testmode.should_not == true
  end
  
  it "send_command method returns an IdealResponse instance" do
    options = {:a => "banklist", :testmode=>true}
    options.merge!({:testmode=>true})  
    payload = Mollie::Ideal.send_command(options)
    payload.class.name.should == "Mollie::IdealResponse"
  end
  
  describe "banklist command" do
    
    it "returns an Array of available banks" do
      Mollie::Ideal.testmode = true
      banks = Mollie::Ideal.banklist
      banks.class.name.should == "Array"
    end
    
  end
  
  describe "prepare payment" do
    
    before do
      Mollie.partner_id = 123456
      Mollie::Ideal.testmode = true
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(
        :get,
        "https://secure.mollie.nl/xml/ideal?description=test%20payment&reporturl=http%3A%2F%2Fwww.postbin.org%2Fwyptsm&amount=1000&returnurl=http%3A%2F%2Fwww.postbin.org%2Fwyptsm&a=fetch&partnerid=123456&bank_id=9999&testmode=true",
        :body => File.read( File.expand_path(File.dirname(__FILE__) + '/../fixtures/fetch_response.xml') ) 
      )
      
    end
    
    after do
      #to make sure the integration specs still work.
      FakeWeb.allow_net_connect = true
    end
    
    it "returns order information" do
      
      order_payload = Mollie::Ideal.prepare_payment(
        9999, #bank_id
        1000, #amount in cents, so this is 10.00
        "test payment", #description
        "http://www.postbin.org/wyptsm",
        "http://www.postbin.org/wyptsm"
      )
      
      #save the transaction_id with the order that is payed.
      order_payload.transaction_id.should == "482d599bbcc7795727650330ad65fe9b"
      #redirect the user to the URL.
      order_payload.URL.should == "https://mijn.postbank.nl/internetbankieren/SesamLoginServlet?sessie=ideal&trxid=003123456789123&random=123456789abcdefgh"
      #this is for checking only..compare this with the order amount. When someone tries to fake an request with a lower amount.. raise an exception...for example.
      order_payload.amount.should == "1000"
      order_payload.currency.should == "EUR"
      
    end
    
    
  end
  
  describe "check payment" do
    
    before do
      Mollie.partner_id = 123456
      Mollie::Ideal.testmode = true
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(
        :get,
        "https://secure.mollie.nl/xml/ideal?partnerid=123456&a=check&testmode=true&transaction_id=482d599bbcc7795727650330ad65fe9b",
        :body => File.read( File.expand_path(File.dirname(__FILE__) + '/../fixtures/check_response.xml') ) 
      )
      
    end
    
    after do
      #to make sure the integration specs still work.
      FakeWeb.allow_net_connect = true
    end
    
    it "returns the order with payed status" do
      
      Mollie::Ideal.testmode = true
      order_payload = Mollie::Ideal.check_order( "482d599bbcc7795727650330ad65fe9b" )
      
      order_payload.transaction_id.should == "482d599bbcc7795727650330ad65fe9b"
      order_payload.payed.should == "true"
      order_payload.consumer.should_not be_nil
            
    end
    
  end
end