require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mollie::IdealResponse do
  
  it "throws an IdealException when it receives an error response from mollie" do
    file = File.read( File.expand_path(File.dirname(__FILE__) + '/../fixtures/errors/1.xml') ) 
    response_mash = Mash.new( Crack::XML.parse(file) )
    lambda {Mollie::IdealResponse.new(response_mash)}.should raise_error(Mollie::IdealException)
  end
  
end