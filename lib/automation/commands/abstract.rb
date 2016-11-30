module Automation
  module Commands
    class Abstract

      def initialize(options = {})
        @options = options
      end

      def run
        true
      end

    end
  end
end
