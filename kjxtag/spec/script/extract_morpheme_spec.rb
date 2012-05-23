# -*- coding: utf-8 -*-
require "spec_helper.rb"

describe "script/extract-morpheme.rb" do
  it "should extract all tags from text" do
    result = `cat #{Kjxtag::SPEC_DIR}/input/script/extract_morpheme/entries.txt | #{Kjxtag::RUBY_CMD} #{Kjxtag::SCRIPT_DIR}/extract-morpheme.rb --all`
    result = result.split(/\n/).map{|line|line.split}
    # result.each do |record|
      # STDERR.puts record.inspect
    # end
    result.shift.should == ["0", "コーディング", "1"]
    result.shift.should == ["0", "スーパーギーク", "1"]
    result.shift.should == ["0", "ソーシャルゲーム", "2"]
    result.shift.should == ["0", "募集", "1"]
    result.shift.should == ["0", "技術", "1"]
    result.shift.should == ["0", "是非", "1"]
    result.shift.should == ["0", "株式会社", "1"]
    result.shift.should == ["0", "ｴﾝｼﾞﾆｱ", "1"]
    result.size.should == 0
  end
  it "should extract tags from text" do
    result = `cat #{Kjxtag::SPEC_DIR}/input/script/extract_morpheme/entries.txt | #{Kjxtag::RUBY_CMD} #{Kjxtag::SCRIPT_DIR}/extract-morpheme.rb --tag #{Kjxtag::SPEC_DIR}/input/script/extract_morpheme/offering-tags.txt`
    result = result.split(/\n/).map{|line|line.split}
    result.shift.should == ["0", "ソーシャルゲーム", "2"]
    result.shift.should == ["0", "技術", "1"]
    result.size.should == 0
  end
end
