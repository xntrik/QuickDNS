require 'yaml'
require 'singleton'

class ChangeDNSConfiguration
  include Singleton

  attr_accessor :config

  def initialize
    @config = YAML.load_file(File.expand_path('..',__FILE__)+"/changedns.yml")
  end
end