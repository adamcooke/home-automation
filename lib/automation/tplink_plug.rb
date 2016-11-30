require 'hs1xx'

module Automation
  class TplinkPlug
    def initialize(name)
      if config = Automation.config.tplink_plugs[name]
        @plug = HS1xx::Plug.new(config.address)
      else
        raise Error, "Invalid tplink plug name '#{name}'"
      end
    end

    def on
      @plug.on
    end

    def off
      @plug.off
    end

    def on?
      @plug.on?
    end

    def off?
      @plug.off?
    end

    def self.on(name)
      self.new(name).on
    end

    def self.off(name)
      self.new(name).off
    end

    def self.statuses
      hash = {}
      Automation.config.tplink_plugs.each do |name, _|
        plug = self.new(name)
        hash[name.to_sym] = plug.on?
      end
      hash
    end

  end
end
