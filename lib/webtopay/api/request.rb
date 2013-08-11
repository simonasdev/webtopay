module WebToPay
  module Api
    class Request < Base
      # Array structure:
      #  * name      – request item name.
      #  * maxlen    – max allowed value for item.
      #  * required  – is this item is required.
      #  * user      – if true, user can set value of this item, if false
      #                item value is generated.
      #  * regexp    – regexp to test item value.
      REQUEST_SPECS = [
        [ :projectid,      11,     true,   true,   /^\d+$/ ],
        [ :orderid,        40,     true,   true,   '' ],
        [ :accepturl,      255,    true,   true,   '' ],
        [ :cancelurl,      255,    true,   true,   '' ],
        [ :callbackurl,    255,    true,   true,   '' ],
        [ :version,        9,      true,   true,   /^\d+\.\d+$/ ],
        [ :lang,           3,      false,  true,   /^[a-z]{3}$/i ],
        [ :amount,         11,     false,  true,   /^\d+$/ ],
        [ :currency,       3,      false,  true,   /^[a-z]{3}$/i ],
        [ :payment,        20,     false,  true,   '' ],
        [ :country,        2,      false,  true,   /^[a-z]{2}$/i ],
        [ :paytext,        255,    false,  true,   '' ],
        [ :p_firstname,    255,    false,  true,   '' ],
        [ :p_lastname,     255,    false,  true,   '' ],
        [ :p_email,        255,    false,  true,   '' ],
        [ :p_street,       255,    false,  true,   '' ],
        [ :p_city,         255,    false,  true,   '' ],
        [ :p_state,        20,     false,  true,   '' ],
        [ :p_zip,          20,     false,  true,   '' ],
        [ :p_countrycode,  2,      false,  true,   /^[a-z]{2}$/i ],
        [ :only_payments,  1,      false,  false,   /^[01]$/ ],
        [ :disalow_payments, 1,      false,  false,   /^[01]$/ ],
        [ :test,           1,      false,  true,  /^[01]$/ ],
        [ :time_limit,  19,      false,  false,   /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/ ],
        [ :personcode,  255,      false,  false,   '' ],
        [ :developerid,  11,      false,  false,  '' ]
      ]

      def request_fields
        REQUEST_SPECS.map{|s| s[0]}
      end

      def encoded_request_data
        Base64.encode64(request_data_string).gsub("\n", "").gsub("/", "_").gsub("+", "-")
      end

      def sign
        Digest::MD5.hexdigest(encoded_request_data + sign_password)
      end

      def build_request_data
        format_request_data
        request_data
      end

      def request_data
        {data: encoded_request_data, sign: sign}
      end

      def request_data_string(additional = nil)
        data_params = request_fields.map{|f| [f.to_s, data[f].to_s.strip]}.
          delete_if{|v| [nil, ""].include? v[1]}
        data_params += additional.map{|k,v| [k.to_s, v]} if additional
        URI.encode_www_form data_params
      end

      def format_request_data
        request_specs.each do |spec|
          name, maxlen, required, user, regexp = spec

          next unless user

          if required && data[name].nil?
            raise_exception(name, Exception::E_MISSING, "#{name} is required but missing.")
          end

          unless data[name].to_s.empty?
            if (maxlen && data[name].to_s.length > maxlen)
              raise_exception(name, Exception::E_MAXLEN, "'#{name}' value '#{data[name]}' is too long, #{maxlen} characters allowed.")
            end

            if ('' != regexp && !data[name].to_s.match(regexp)) 
              raise_exception(name, E_REGEXP, "'#{name}' value '#{data[name]}' is invalid.")
            end
          end

          if !data[name].nil?
            request_data[name] = data[name]
          end
        end

        request_data
      end

      def raise_exception(name, code, msg)
        e = Exception.new(msg)
        e.code = code
        e.field_name = name
        raise e
      end

    end
  end
end
