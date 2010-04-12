$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'mollie-ideal'
require 'spec'
require 'spec/autorun'
require 'fakeweb'
Spec::Runner.configure do |config|
  
end
