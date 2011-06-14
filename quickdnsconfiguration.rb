require 'yaml'
require 'singleton'

class QuickDNSConfiguration
  include Singleton

  attr_accessor :config

  def initialize
    @config = YAML.load_file(File.expand_path('..',__FILE__)+"/quickdns.yml")
  end
end