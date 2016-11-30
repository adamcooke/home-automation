require 'hashie/mash'
require 'yaml'
module Automation
  def self.config
    @config ||= Hashie::Mash.new(YAML.load_file(File.expand_path('../../../config.yml', __FILE__)))
  end
end
