#encoding: UTF-8
require 'spec_helper'
require 'cgi'

describe WebToPay::Api::Response do
  
  let(:cert_file) {File.join(File.dirname(__FILE__), '..', 'fixtures', 'webtopay.key')}
  let(:valid_data) {{version: "1.6", status: "1"}}

  context "data" do
    it "should extract" do 
      response('dmVyc2lvbj0xLjYmc3RhdHVzPTE=').data.should == valid_data
    end
  end
  
  context "response" do
    
    it "should check signature" do
      mock_signature_verification
      response('dmVyc2lvbj0xLjYmc3RhdHVzPTE=').check_response.should == valid_data 
    end
    
    it "should raise error if its not valid" do
      stub_key_download
      expect {
        response('dmVyc2lvbj0xLjYmc3RhdHVzPTE=').check_response
      }.to raise_error('Can\'t verify ss2')
    end
    
    it "should validate version" do
      mock_signature_verification
      expect {
        response('dmVyc2lvbj0xLjcmc3RhdHVzPTE=').check_response
      }.to raise_error("Incompatible library and response versions: libwebtopay 1.6, response 1.7")
    end
  end
  
  def mock_signature_verification
    stub_key_download
    OpenSSL::X509::Certificate.should_receive(:new).and_return(
      double("cert", public_key: double("key", verify: true))
    )
  end

  def stub_key_download
    WebToPay::Api::Response.any_instance.stub(:open).and_return(double("cert", read: File.read(cert_file)))
  end

  def response(data)
    WebToPay::Api::Response.new(data, 'test_ss2')
  end
end
