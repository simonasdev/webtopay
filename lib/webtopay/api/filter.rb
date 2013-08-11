module WebToPay
  module Api
    class Filter

      attr_accessor :source

      def initialize(source)
        @source = source
      end

      def result
        source
      end

      def where(name, key, value)
        @source = source[name].select{|s| s[key] == value}[0]
        self
      end

    end
  end
end
