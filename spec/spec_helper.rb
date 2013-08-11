require 'rubygems'
require 'bundler/setup'
require 'httparty'
require 'json'

require_relative "../init"

RSpec.configure do |c|
  c.before(:each) do
    WebToPay.configure do |config|
      config.project_id = 12345
      config.sign_password = 'test_password'
    end
  end
end

def request_params
  {
    orderid: 1234,
    amount: 1000,
    currency: 'LTL',
    accepturl: 'http://test.local',
    cancelurl: 'http://test2.local',
    callbackurl: 'http://test3.local',
    test: 1,
    payment: 'mb'
  }
end
