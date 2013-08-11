#encoding: UTF-8
require 'spec_helper'

describe WebToPay::Api::PaymentMethod do

  let(:params) { {language: 'lt', payment_group: 'e-banking', country: 'lt'} }
  let(:parsed_response) {MultiJson.load(File.read(File.join(File.dirname(__FILE__), '..', 'fixtures', 'payment_methods.json')))}
  let(:api_path) {
    "/new/api/paymentMethods/#{WebToPay.config.project_id}/currency:#{request_params[:currency]}/amount:#{request_params[:amount]}"
  }
  let(:httparty_response) { double('json', parsed_response: parsed_response) }

  it "should return all payment methods" do
    WebToPay::Api::PaymentMethod.should_receive(:get).with(api_path).and_return(httparty_response)
    WebToPay::Api::PaymentMethod.new(request_params).all(params).should == [
      ["parex", "AB Citadele bankas"],
      ["sampo", "AB Danske bankas"],
      ["nordealt", "AB Nordea bankas"],
      ["vb2", "AB SEB bankas"],
      ["nord", "AB bankas \"DNB\""],
      ["hanza", "AB bankas \"Swedbank\""],
      ["sb", "AB Šiaulių bankas"],
      ["mb", "UAB Medicinos bankas"],
      ["lku", "lku"]
    ]
  end

end
