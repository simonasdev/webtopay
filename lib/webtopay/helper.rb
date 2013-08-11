module WebToPay
  module Helper
    def webtopay_macro_form(params = {})
      request_data = WebToPay::Api::Request.new(params).request_data

      form_tag(WebToPay.config.request_url, method: :post, authenticity_token: false, id: "webtopay_form") do
        concat hidden_field_tag 'data', request_data[:data]
        concat hidden_field_tag 'sign', request_data[:sign]
      end
    end
  end
end
