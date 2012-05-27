require "tx"

module Kjxutil
  module TxUtil
    def self.load_trie_map(trie_map_path)
      return Tx::Map.open(trie_map_path)
    end
    
    def self.create_trie_map(input_stream, output_path)
      builder = Tx::MapBuilder.new
      
      while line = input_stream.gets do
        line.chomp!
        record = line.split(/\t/)
        key = record[0]
        val = record[1]
        builder.add(key, val)
      end
      
      builder.build(output_path)
    end
  end
end

