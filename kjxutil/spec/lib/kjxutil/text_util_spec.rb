# -*- coding: utf-8 -*-
require "spec_helper.rb"

describe Kjxutil::TextUtil do
  describe "#normalize(text)" do
    context "when text = 'Ｓｕｐｅｒ'" do
      it "should return 'Super'" do
        Kjxutil::TextUtil.normalize("Ｓｕｐｅｒ").should == "Super"
      end
    end
    context "when text = 'ｴﾝｼﾞﾆｱ'" do
      it "should return 'エンジニア'" do
        Kjxutil::TextUtil.normalize("ｴﾝｼﾞﾆｱ").should == "エンジニア"
      end
    end
    context "when text = '（）｛｝“”‘’－‐―！＃＄％＆＝｜＾￥＠＋＊；：＜＞？＿／．'" do
      it "should return '(){}\"\"''---!\#$%&=|^¥@+*;:<>?_/.'" do
         Kjxutil::TextUtil.normalize("（）｛｝“”‘’－‐―！＃＄％＆＝｜＾￥＠＋＊；：＜＞？＿／．").should == "(){}\"\"''---!\#$%&=|^¥@+*;:<>?_/."
      end
    end
  end
end

