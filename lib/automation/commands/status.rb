require 'automation/hue'
require 'automation/tplink_plug'

module Automation
  module Commands
    class Status

      def run
        # Get the state of all hue lights across all bridges
        puts ("-" * 80).blue
        puts "Lighting".blue
        puts ("-" * 80).blue
        Automation.config.hue.each do |name, _|
          hue = Automation::Hue.new(name)
          hue.lights.each do |id, light|
            print id.to_s.ljust(4, ' ')
            print light.name.to_s.ljust(40, ' ')
            print light.state.on ? 'On'.green : 'Off'.red
            puts
          end
        end
        puts
        puts ("-" * 80).blue
        puts "Plugs".blue
        puts ("-" * 80).blue
        Automation.config.tplink_plugs.each do |name, _|
          plug = Automation::TplinkPlug.new(name)
          print name.to_s.ljust(44, ' ')
          print plug.on? ? 'On'.green : 'Off'.red
          puts
        end

      end

    end
  end
end
