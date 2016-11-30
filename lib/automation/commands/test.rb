require 'automation/tplink_plug'

module Automation
  module Commands
    class Test

      def run
        plug = TplinkPlug.new(:plug1)
        puts plug.off
      end

    end
  end
end
