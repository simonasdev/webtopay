module WebToPay
  module ControllerHelper
    module ClassMethods
      def webtopay(*actions)
        before_action :webtopay_check, only: actions
        attr_reader :webtopay_data
      end
    end

    def self.included(controller)
      controller.extend(ClassMethods)
    end

    protected

    def webtopay_check
      begin
        @webtopay_data = WebToPay::Api::Response.new(params[:data], params[:ss2]).check_response
      rescue WebToPay::Exception => e
        render plain: e.message, status: 500
      end
    end
  end
end
