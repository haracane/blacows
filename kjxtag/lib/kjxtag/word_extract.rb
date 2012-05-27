# encoding: utf-8
module Kjxtag
  module WordExtract
    
    def self.extract_words(input_stream, output_stream, options={})
      mecab = MeCab::Tagger.new()
      
      while line = input_stream.gets do
        line.chomp!
        record = JSON.parse(line)
        entry_id = record["id"]
        description = record["description"]
        description = Kjxutil::TextUtil.normalize(description)
        node = mecab.parseToNode(description)
      
        tag_count_hash = {}

        while node do
          surface = Kjxutil::MecabUtil.get_surface(node)
          feature = Kjxutil::MecabUtil.get_feature_record(node)
          hinshi = feature.shift
          hinshi.force_encoding("utf-8")
          case hinshi
          when "名詞"
            length = surface.length
            if 1 < length then
              tag_count_hash[surface] = (tag_count_hash[surface] || 0 ) + 1
            end
          end
          node = node.next
        end

        tag_count_hash.keys.sort.each do |key|
          output_stream.puts "#{entry_id}\t#{key}\t#{tag_count_hash[key]}"
        end
      end
    end
  end
end