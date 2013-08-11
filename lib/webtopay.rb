require 'rubygems'
require 'digest/md5'
require 'openssl'
require 'open-uri'
require 'httparty'

module WebToPay
  class << self
    attr_accessor :config

    def configure
      self.config ||= Configuration.new
      yield(config)
    end
  end

  autoload :Exception, 'webtopay/exception'
  autoload :Configuration, 'webtopay/configuration'
  autoload :ControllerHelper, 'webtopay/controller_helper'
  autoload :Helper, 'webtopay/helper'
  autoload :Configuration, 'webtopay/configuration'

  module Api
    autoload :Base, 'webtopay/api/base'
    autoload :Request, 'webtopay/api/request'
    autoload :Response, 'webtopay/api/response'
    autoload :PaymentMethod, 'webtopay/api/payment_method'
    autoload :Filter, 'webtopay/api/filter'
  end

end

