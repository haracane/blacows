
require "rubygems"
autoload :NKF, "nkf"
autoload :CSV, "csv"
autoload :StringIO, "stringio"

module Kjxutil
  autoload :MecabUtil, "kjxutil/mecab_util"
  autoload :RspecUtil, "kjxutil/rspec_util"
  autoload :TextUtil, "kjxutil/text_util"
  autoload :TxUtil, "kjxutil/tx_util"

  KJXUTIL_HOME  = File.dirname(File.dirname(__FILE__))

  def self.logger
    @logger ||= (rails_logger || default_logger)
  end

  def self.rails_logger
    (defined?(Rails) && Rails.respond_to?(:logger) && Rails.logger) ||
    (defined?(RAILS_DEFAULT_LOGGER) && RAILS_DEFAULT_LOGGER.respond_to?(:debug) && RAILS_DEFAULT_LOGGER)
  end

  def self.default_logger
    require 'logger'
    l = Logger.new(STDERR)
    l.level = Logger::INFO
    l
  end

  def self.logger=(logger)
    @logger = logger
  end
end