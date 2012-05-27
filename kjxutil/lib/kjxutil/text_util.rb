# -*- coding: utf-8 -*-
module Kjxutil
  module TextUtil
    #  ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ｳﾞ
    #  ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ
    #  ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ｦ ﾝ ｬ ｭ ｮ ｧ ｨ ｩ ｪ ｫ ｯ ﾞ ﾟ 
    #  ０ １ ２ ３ ４ ５ ６ ７ ８ ９
    #  ａ ｂ ｃ ｄ ｅ ｆ ｇ ｈ ｉ ｊ ｋ ｌ ｍ ｎ ｏ ｐ ｑ ｒ ｓ ｔ ｕ ｖ ｗ ｘ ｙ ｚ
    #  Ａ Ｂ Ｃ Ｄ Ｅ Ｆ Ｇ Ｈ Ｉ Ｊ Ｋ Ｌ Ｍ Ｎ Ｏ Ｐ Ｑ Ｒ Ｓ Ｔ Ｕ Ｖ Ｗ Ｘ Ｙ Ｚ
    @@normalize_from = %w(
      ０-９
      ａ-ｚ
      Ａ-Ｚ
      （ ） ｛ ｝ ‘ ’ “ ”
      － ‐ ―
      ！ ＃ ＄ ％ ＆ ＝ ｜ ＾ ￥ ＠ ＋ ＊ ； ： ＜ ＞ ？ ＿ ／ ．
    ).join
    #  ガ ギ グ ゲ ゴ ザ ジ ズ ゼ ゾ ダ ヂ ヅ デ ド バ ビ ブ ベ ボ パ ピ プ ペ ポ ヴ
    #  ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ ハ ヒ フ ヘ ホ
    #  マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン ヤ ユ ヨ ア イ ウ エ オ ッ ゛ ゜
    #  0 1 2 3 4 5 6 7 8 9
    #  a b c d e f g h i j k l m n o p q r s t u v w x y z
    #  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
    @@normalize_to = %w(
      0-9
      a-z
      A-Z
      \( \) { } ' ' " "
      \\- \\- \\-
      ! # $ % & = | ^ ¥ \@ + * ; : < > ? _ / .
    ).join
    @@normalize_hash = {}
    @@normalize_from.size.times do |i|
      @@normalize_hash[@@normalize_from[i]] = @@normalize_to[i]
    end
    
    @@ignore_case_from = %w(
      A-Z ぁ-ぉ ァ-ォ
    ).join
    @@ignore_case_to = %w(
      a-z あ-お ア-オ
    ).join
    
    def self.normalize(text)
      text = text.tr(@@normalize_from, @@normalize_to)
      text = NKF::nkf( '-WwXm0', text)
      return text
    end
    def self.ignore_case(text)
      return text.tr(@@ignore_case_from, @@ignore_case_to)
    end
  end
end