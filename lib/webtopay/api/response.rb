module WebToPay
  module Api
    class Response < Base
      # array structure:
      # * name       – request item name.
      # * maxlen     – max allowed value for item.
      # * required   – is this item is required in response.
      # * mustcheck  – this item must be checked by user.
      # * isresponse – if false, item must not be included in response array.
      # * regexp     – regexp to test item value.
      MACRO_RESPONSE_SPECS = [
        [ :projectid,       11,     true,   true,   true,  /^\d+$/ ],
        [ :orderid,         40,     false,  false,  true,  '' ],
        [ :lang,            3,      false,  false,  true,  /^[a-z]{3}$/i ],
        [ :amount,          11,     false,  false,  true,  /^\d+$/ ],
        [ :currency,        3,      false,  false,  true,  /^[a-z]{3}$/i ],
        [ :payment,         20,     false,  false,  true,  '' ],
        [ :country,         2,      false,  false,  true,  /^[a-z]{2}$/i ],
        [ :paytext,         0,      false,  false,  true,  '' ],
        [ :_ss2,            0,      true,   false,  true,  '' ],
        [ :_ss1,            0,      false,  false,  true,  '' ],
        [ :name,            255,    false,  false,  true,  '' ],
        [ :surename,        255,    false,  false,  true,  '' ],
        [ :status,          255,    false,  false,  true,  '' ],
        [ :error,           20,     false,  false,  true,  '' ],
        [ :test,            1,      false,  false,  true,  /^[01]$/ ],
        [ :p_email,         0,      false,  false,  true,  '' ],
        [ :payamount,       0,      false,  false,  true,  '' ],
        [ :paycurrency,     0,      false,  false,  true,  '' ],
        [ :version,         9,      true,   false,  true,  /^\d+\.\d+$/ ],
        [ :sign_password,   255,    false,  true,   false, '' ]
      ]

      # specification array for mikro response.
      #
      # array structure:
      # * name       – request item name.
      # * maxlen     – max allowed value for item.
      # * required   – is this item is required in response.
      # * mustcheck  – this item must be checked by user.
      # * isresponse – if false, item must not be included in response array.
      # * regexp     – regexp to test item value.
      MIKRO_RESPONSE_SPECS = [
        [ :to,              0,      true,   false,  true,  '' ],
        [ :sms,             0,      true,   false,  true,  '' ],
        [ :from,            0,      true,   false,  true,  '' ],
        [ :operator,        0,      true,   false,  true,  '' ],
        [ :amount,          0,      true,   false,  true,  '' ],
        [ :currency,        0,      true,   false,  true,  '' ],
        [ :country,         0,      true,   false,  true,  '' ],
        [ :id,              0,      true,   false,  true,  '' ],
        [ :_ss2,            0,      true,   false,  true,  '' ],
        [ :_ss1,            0,      true,   false,  true,  '' ],
        [ :test,            0,      true,   false,  true,  '' ],
        [ :key,             0,      true,   false,  true,  '' ]
      ]

      attr_accessor :query, :ss2, :original_data

      def initialize(data, ss2)
        raise_exception("Invalid params") if data.nil? || ss2.nil?

        @data = decode(data)
        @original_data = data.dup
        @ss2 = decode(ss2)
        extract_data
      end

      def cert_path
        config.cert_path
      end

      def public_key
        @public_key ||= OpenSSL::X509::Certificate.new(open(cert_path).read).public_key
      end

      def response_type
        !data[:to].nil? && !data[:from].nil? ? :mikro : :makro
      end

      def makro?
        response_type == :makro
      end

      def mikro?
        response_type == :mikro
      end

      def decode(string)
        Base64.decode64(string.gsub('-','+').gsub('_','/'))
      end

      def extract_data
        @data = symbolize(CGI.parse(data))
      end

      def symbolize(data)
        Hash[data.map{|a| [a.first.to_sym, a.last[0]]}]
      end

      def check_response
        verify_cert
        verify_version if makro?

        data
      end

      def verify_version
        if data[:version] != API_VERSION
          raise_exception("Incompatible library and response versions: libwebtopay #{API_VERSION}, response #{data[:version]}")
        end
      end

      def verify_cert
        raise_exception("Can\'t get openssl public key for #{cert}") if !public_key
        if !public_key.verify(OpenSSL::Digest::SHA1.new, ss2, original_data)
          raise_exception('Can\'t verify ss2')
        end
      end

      def raise_exception(*args)
        e = Exception.new(*args)
        e.code = Exception::E_INVALID
        raise e
      end

    end
  end
end
