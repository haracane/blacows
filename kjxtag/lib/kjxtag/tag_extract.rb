module Kjxtag
  module TagExtract
    def self.load_tag_id_hash(tags_path)
      ret = {}
      open(tags_path, "r:utf-8") do |f|
        while line = f.gets do
          line.chomp!
          record = line.split(/\t/)
          tag_id = record[0]
          tag_name = record[1]
          ret[tag_name] = tag_id
        end
      end
      return ret
    end
    
    def self.load_tag_weights_hash(keywords_path, options={})
      if options[:tag_id_hash] then
        tag_id_hash = options[:tag_id_hash]
      elsif options[:tags_path] then
        tag_id_hash = self.load_tag_id_hash(options[:tags_path])
      end
      
      ret = {}
      open(keywords_path, "r:utf-8") do |f|
        while line = f.gets do
          line.chomp!
          record = line.split(/\t/)
          keyword = record[0]
          val = record[1]
          if val.nil? || val == "" then
            tag_weights = {keyword=>1}
          else
            tag_weights = JSON.parse(val)
          end
          if tag_id_hash then
            tag_id_weights = {}
            tag_weights.each_pair do |tag_name, weight|
              tag_id = tag_id_hash[tag_name]
              next if tag_id.nil?
              tag_id_weights[tag_id] = weight
            end
            ret[keyword] = tag_id_weights
          else
            ret[keyword] = tag_weights
          end
        end
      end
      return ret
    end

    def self.output_tag_id_weights(output_stream, tags_path, keywords_path)
      tag_weights_hash = self.load_tag_weights_hash(keywords_path, :tags_path=>tags_path)
      tag_weights_hash.each_pair do |keyword, tag_weights|
        output_stream.print keyword
        output_stream.print "\t"
        output_stream.puts tag_weights.to_json
      end
    end
    def self.extract_tags(input_stream, output_stream, options={})
      tx_trie_map = Kjxutil::TxUtil.load_trie_map(options[:tx_trie_map_path])
      while line = input_stream.gets do
        line.chomp!
        record = JSON.parse(line)
        entry_id = record["id"]
        description = record["description"]
        description = Kjxutil::TextUtil.normalize(description)
      
        tag_count_hash = {}
        
        results = tx_trie_map.scan(description)
        results.each do |result|
          tag_id_info = JSON.parse(result[2])
          tag_id_info.each_pair do |tag_id, weight|
            tag_count_hash[tag_id] = (tag_count_hash[tag_id] || 0 ) + weight
          end
        end
        
        tag_count_hash.keys.sort.each do |key|
          output_stream.puts "#{entry_id}\t#{key}\t#{tag_count_hash[key]}"
        end
      end
    end
  end
end