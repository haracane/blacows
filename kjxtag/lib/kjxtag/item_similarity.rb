module Kjxtag
  module ItemSimilarity
    
    def self.output_item_similarity_scores(item_tag_scores_path_1, item_tag_scores_path_2, tag_idf_scores_path, output_stream)
      tag_score_vectors_1 = nil
      tag_score_vectors_2 = nil
      idf_score_hash = nil
      open(item_tag_scores_path_1, "r:utf-8") do |f|
        tag_score_vectors_1 = Kjxtag::ItemTagScore.load_tag_score_vectors(f)
      end
      open(item_tag_scores_path_2, "r:utf-8") do |f|
        tag_score_vectors_2 = Kjxtag::ItemTagScore.load_tag_score_vectors(f)
      end
      open(tag_idf_scores_path, "r:utf-8") do |f|
        idf_score_hash = Kjxtag::TagScore.load_scores(f)
      end
      item_similarity_scores = {}
      self.update_item_similarity_scores(tag_score_vectors_1, tag_score_vectors_2, idf_score_hash, item_similarity_scores)
      item_similarity_scores.each_pair do |item_id_1, scores|
        scores.each_pair do |item_id_2, score|
          output_stream.print item_id_1
          output_stream.print "\t"
          output_stream.print item_id_2
          output_stream.print "\t"
          output_stream.puts score
        end
      end
    end
    
    def self.calculate_item_similarity_score(tag_score_vector1, tag_score_vector2, idf_score_hash)
      ret = 0
      tag_score_vector1.each_pair do |tag_id, score1|
        score2 = tag_score_vector2[tag_id]
        next if score2.nil?
        idf_score = idf_score_hash[tag_id]
        ret += score1 * score2 * idf_score
      end
      return ret
    end
    
    def self.update_item_similarity_scores(tag_score_vectors_1, tag_score_vectors_2, idf_score_hash, item_similarity_scores={})
      item_id_list_1 = tag_score_vectors_1.keys
      item_id_list_2 = tag_score_vectors_2.keys
      item_id_list_1.each do |item_id_1|
        item_similarity_scores[item_id_1] ||= {}
        scores = item_similarity_scores[item_id_1]
        tag_score_vector_1 = tag_score_vectors_1[item_id_1]
        item_id_list_2.each do |item_id_2|
          next if item_id_2 <= item_id_1
          tag_score_vector_2 = tag_score_vectors_2[item_id_2]
          score = self.calculate_item_similarity_score(tag_score_vector_1, tag_score_vector_2, idf_score_hash)
          scores[item_id_2] = score
        end
      end
    end
    
    # def self.calculate_item_similarity_scores(tag_score_vectors, idf_score_hash)
      # ret = {}
      # item_id_list = tag_score_vectors.keys
      # count = item_id_list.size
      # count.times do |i|
        # scores = {}
        # ret[i] = scores
        # i_item_id = item_id_list[i]
        # (i+1).upto(count - 1).each do |j|
          # j_item_id = item_id_list[j]
          # score = self.calculate_item_similarity_score(tag_score_vectors[i_item_id], tag_score_vectors[j_item_id], idf_score_hash)
          # scores[j_item_id] = score
        # end
      # end
      # return ret
    # end
    
  end
end