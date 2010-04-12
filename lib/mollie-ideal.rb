$LOAD_PATH.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end
require 'httparty'
require 'mash'

module Mollie

  autoload :Ideal, 'mollie/ideal'
  autoload :IdealResponse, 'mollie/ideal_response'
  autoload :IdealException, 'mollie/ideal_exception'
  
  class << self
    attr_accessor :partner_id
  end
  
end