require "spec_helper"

describe Kjxtag::ItemSimilarity do
  describe "#output_item_similarity_scores(item_tag_scores_path_1, item_tag_scores_path_2, tag_idf_scores_path, output_stream)" do
    item_tag_scores_path_1 = item_tag_scores_path_2 = "#{Kjxtag::SPEC_INPUT_DIR}/offering-item-tag-scores.txt"
    tag_idf_scores_path = "#{Kjxtag::SPEC_INPUT_DIR}/offering-tag-idf-scores.txt"
    context "when item_tag_scores_path_1 = \"#{item_tag_scores_path_1}\", item_tag_scores_path_2 = \"#{item_tag_scores_path_2}\", tag_id_scores_path = \"#{tag_idf_scores_path}\", output_stream = STDOUT" do
      it "should output item_similarity_scores" do
        result = Kjxutil::RspecUtil.capture(:stdout) do
          Kjxtag::ItemSimilarity.output_item_similarity_scores(item_tag_scores_path_1, item_tag_scores_path_2, tag_idf_scores_path, $stdout)
        end
        result = result.split(/\n/).map{|line| line.split(/\t/)}
        result.shift.should == ["0", "1", "206"]
        result.shift.should == ["0", "2", "103"]
        result.shift.should == ["1", "2", "103"]
      end
    end
  end
end

