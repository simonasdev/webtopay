module WebToPay
  module Api
    class PaymentMethod < Base
      include HTTParty

      base_uri 'https://www.mokejimai.lt'

      def all_url
        "/new/api/paymentMethods/#{project_id}/currency:#{data[:currency]}/amount:#{data[:amount]}"
      end

      def fetch_all_xml
        self.class.get(all_url).parsed_response
      end

      # Fetches all payment methods filtered by given params:
      # * country:
      #   lt
      #   de
      #   ee
      #   ..
      # * payment_group
      #   e-banking
      #   e-money
      #   other
      # * language
      #   lt
      #   en
      #   ru
      #   lv
      def all(filters)
        filter = Filter.new(fetch_all_xml['payment_types_document']).
          where('country', 'code', filters[:country]).
          where('payment_group', 'key', filters[:payment_group])

        filter.result['payment_type'].map{|t|
          f = Filter.new(t).where('title', 'language', filters[:language])
          [t['key'], f.result['__content__']]
        }.sort!{|x,y| x[1] <=> y[1]}
      end
    end
 end
end
