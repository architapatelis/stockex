require 'stockex/configuration'
require 'stockex/equity'

#the configuration method will allow users of this gem to configure their API Key.
module Stockex
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
