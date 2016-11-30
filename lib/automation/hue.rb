require 'hue'
require 'json'

module Automation
  class Hue

    def initialize(name)
      @name = name
      @ip_address = Automation.config.hue[name.to_sym].address || raise(Error, "Invalid hue bridge ip address for #{name}")
      @username = Automation.config.hue[name.to_sym].username || raise(Error, "Invalid hue bridge username for #{name}")
    end

    def lights
      get('lights').body
    end

    def self.statuses
      hash = {}
      Automation.config.hue.each do |name, _|
        bridge = self.new(name)
        bridge.lights.each do |id, light|
          hash[light.name] = light.state.on
        end
      end
      hash
    end

    private

    def get(path)
      request(Net::HTTP::Get, path)
    end

    def request(method, path, body = nil)
      request = method.new("/api/#{@username}/#{path}")
      request.body = body if body
      request.add_field('Content-Type', 'application/json')
      connection = Net::HTTP.new(@ip_address, 80)
      result = connection.request(request)
      if result['content-type'] && result['content-type'].include?('application/json')
        body = JSON.parse(result.body)
      else
        body = result.body
      end
      if result.code.to_i == 200
        Hashie::Mash.new({:code => result.code.to_i, :body => body, :headers => result.to_hash})
      else
        raise Error, "Hue code #{result.code} (#{body})"
      end
    end

  end
end
