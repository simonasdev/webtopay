require 'spec_helper'

describe WebToPay::Api::Request do

  context "data" do

    let(:request) { WebToPay::Api::Request.new(request_params) }

    it "should return request data" do
      request.request_data.should == {
        data: 'cHJvamVjdGlkPTEyMzQ1Jm9yZGVyaWQ9MTIzNCZhY2NlcHR1cmw9aHR0cCUzQSUyRiUyRnRlc3QubG9jYWwmY2FuY2VsdXJsPWh0dHAlM0ElMkYlMkZ0ZXN0Mi5sb2NhbCZjYWxsYmFja3VybD1odHRwJTNBJTJGJTJGdGVzdDMubG9jYWwmdmVyc2lvbj0xLjYmYW1vdW50PTEwMDAmY3VycmVuY3k9TFRMJnBheW1lbnQ9bWImdGVzdD0x',
        sign: '5a5456fe10c3fb6b057a209352688fa8'
      }
    end

  end
end
