require 'automation/hue'
require 'automation/tplink_plug'

module Automation
  module Commands
    class Run

      def run
        puts "Running Automation..."
        loop do
          begin
            check_lighting_status
            sleep 1
          rescue => e
            puts "#{e.class}: #{e.message}".red
            puts e.backtrace[0,5].map(&:red)
            sleep 15
          end
        end
      end

      private

      def check_lighting_status
        #
        # Get the statuses of the all the lights on the system
        #
        light_statuses = Hue.statuses

        #
        # Get the statuses of all the plugs on the system
        #
        plug_statuses = TplinkPlug.statuses

        #
        # If any of the living room lights are on, switch on the Christmas tree
        #
        living_room_lights = ['Living Room (main)', 'Living Room (window side lamp)', 'Living Room (wall side lamp)']
        if living_room_lights.any? { |light| light_statuses[light] }
          unless plug_statuses[:xmas_tree]
            puts "Switching Xmas Tree plug on because it's off and the lights are on"
            TplinkPlug.on(:xmas_tree)
          end
        else
          if plug_statuses[:xmas_tree]
            puts "Switching Xmas Tree plug off because it's on and the lights are off"
            TplinkPlug.off(:xmas_tree)
          end
        end

        # Any additional rules which depend on the state of lights etc... should be
        # added here.
      end

    end
  end
end
