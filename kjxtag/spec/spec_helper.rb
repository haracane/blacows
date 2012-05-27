$:.push("#{File.dirname(__FILE__)}/../lib")

require 'rubygems'
require 'rspec'
require 'tempfile'
require "kjxtag"

module Kjxtag
  SPEC_DIR = "#{KJXTAG_HOME}/spec"
  SPEC_INPUT_DIR = "#{SPEC_DIR}/data/input"
  SPEC_EXPECT_DIR = "#{SPEC_DIR}/data/expect"
end

# ActiveRecord::Base.establish_connection({
  # :adapter=>'postgresql',
  # :host=>'localhost',
  # :port=>5432,
  # :username=>'postgres',
  # :password=>'postgres', 
  # :encoding=>'utf8',
  # :database=>'trendword'
# })

Kjxtag.logger = Logger.new(STDERR)
if File.exist?('/tmp/twitter-crawl.debug') then
  Kjxtag.logger.level = Logger::DEBUG
  Kjxtag::REDIRECT[:stderr] = nil
else
  Kjxtag.logger.level = Logger::ERROR
  Kjxtag::REDIRECT[:stderr] = "2> /dev/null"
end
