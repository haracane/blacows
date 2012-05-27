# encoding: utf-8
$:.push("#{File.dirname(__FILE__)}/../../kjxutil/lib")

require "rubygems"
require "json"
require "logger"
require "awesome_print"

autoload :Kjxutil, "kjxutil"
autoload :CSV, "csv"
autoload :MeCab, "MeCab"


module Kjxtag
  
  autoload :ItemSimilarity, "kjxtag/item_similarity"
  autoload :ItemTagScore, "kjxtag/item_tag_score"
  autoload :Load, "kjxtag/load"
  autoload :TagExtract, "kjxtag/tag_extract"
  autoload :TagScore, "kjxtag/tag_score"
  autoload :WordExtract, "kjxtag/word_extract"
    
  KJXTAG_HOME  = File.dirname(File.dirname(__FILE__))
  BIN_DIR = "#{KJXTAG_HOME}/bin"
  LIB_DIR = "#{KJXTAG_HOME}/lib"
  SCRIPT_DIR = "#{KJXTAG_HOME}/script"
  TEST_DIR = "#{KJXTAG_HOME}/test"
  RUBY_CMD = "ruby -I #{LIB_DIR}"
  DEFAULT_CONF_PATH = "#{KJXTAG_HOME}/conf/config.yml"
  REDIRECT = {:stdout=>"1> /dev/null", :stderr=>"2> /dev/null"}

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
