module WebToPay
  module Api
    class Base

      API_VERSION = "1.6"

      attr_accessor :data

      def initialize(data)
        @data = symbolize(data)
        set_default_data
      end

      def set_default_data
        @data[:projectid] = project_id
        @data[:sign_password] = sign_password
        @data[:version] = API_VERSION
      end

      def config
        WebToPay.config
      end

      def project_id
        config.project_id
      end

      def sign_password
        config.sign_password
      end

      def symbolize(data)
        Hash[data.map{|a| [a.first.to_sym, a.last]}]
      end
    end
  end
end
