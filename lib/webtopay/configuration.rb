module WebToPay
  class Configuration
    attr_accessor :project_id, :sign_password, :request_url

    def cert_path
      @cert_path || 'http://downloads.webtopay.com/download/public.key'
    end

    def request_url
      @request_url || 'https://www.mokejimai.lt/pay'
    end
  end
end
