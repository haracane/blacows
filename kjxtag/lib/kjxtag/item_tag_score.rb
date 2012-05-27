module Kjxtag
  module ItemTagScore
    
    def self.load_tag_score_vectors_from_file(tag_scores_path)
      ret = nil
      open(tag_scores_path, "r:utf-8") do |f|
        ret = self.load_tag_score_vectors(f)
      end
      return ret
    end    
    
    def self.load_tag_score_vectors(input_stream)
      ret = {}
      prev_item_id = nil
      vector = {}
      while line = input_stream.gets do
        line.chomp!
        record = line.split(/\t/)
        item_id = record[0].to_i
        tag_id = record[1].to_i
        score = record[2].to_i
        if item_id == prev_item_id then
          vector[tag_id] = score
        else
          if prev_item_id then
            ret[prev_item_id] = vector
          end
          vector = {}
          vector[tag_id] = score
        end
        prev_item_id = item_id
      end
      if prev_item_id then
        ret[prev_item_id] = vector
      end
      return ret
    end
  end
end