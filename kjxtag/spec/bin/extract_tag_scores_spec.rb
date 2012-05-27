# -*- coding: utf-8 -*-
require "spec_helper.rb"

describe "bin/extract-tag-scores" do
  before :all do
    @stderr_redirect = Kjxtag::REDIRECT[:stderr]
  end
  it "should extract tags from text" do
    result = `cat #{Kjxtag::SPEC_DIR}/data/input/offers.txt | sh #{Kjxtag::BIN_DIR}/extract-tag-scores #{Kjxtag::SPEC_DIR}/etc/trie/offering-trie #{@stderr_redirect}`
    result = result.split(/\n/).map{|line|line.split}
    # result.each do |record| STDERR.puts record.inspect end
    result.shift.should == ["0", "0", "2"]
    result.shift.should == ["0", "10", "1"]
    result.shift.should == ["0", "6", "1"]
    result.shift.should == ["1", "0", "1"]
    result.shift.should == ["1", "10", "1"]
    result.shift.should == ["1", "6", "1"]
    result.shift.should == ["2", "0", "1"]
    result.size.should == 0
  end
end
