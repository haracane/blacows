# -*- coding: utf-8 -*-
require "spec_helper.rb"

describe "bin/extract-words" do
  before :all do
    @stderr_redirect = Kjxtag::REDIRECT[:stderr]
  end
  it "should extract words from text" do
    result = `cat #{Kjxtag::SPEC_DIR}/data/input/offers.txt | sh #{Kjxtag::BIN_DIR}/extract-words #{@stderr_redirect}`
    result = result.split(/\n/).map{|line|line.split}
    # result.each do |record| STDERR.puts record.inspect end
    result.shift.should == ["0", "エンジニア", "1"]
    result.shift.should == ["0", "コーディング", "1"]
    result.shift.should == ["0", "スーパーギーク", "1"]
    result.shift.should == ["0", "ソーシャルゲーム", "2"]
    result.shift.should == ["0", "募集", "1"]
    result.shift.should == ["0", "技術", "1"]
    result.shift.should == ["0", "是非", "1"]
    result.shift.should == ["0", "株式会社", "1"]
    result.shift.should == ["1", "エンジニア", "1"]
    result.shift.should == ["1", "コーディング", "1"]
    result.shift.should == ["1", "スーパーギーク", "1"]
    result.shift.should == ["1", "ソーシャルゲーム", "1"]
    result.shift.should == ["1", "募集", "1"]
    result.shift.should == ["1", "技術", "1"]
    result.shift.should == ["1", "株式会社", "1"]
    result.shift.should == ["2", "ソーシャルゲーム", "1"]
    result.shift.should == ["2", "是非", "1"]
    result.size.should == 0
  end
end
