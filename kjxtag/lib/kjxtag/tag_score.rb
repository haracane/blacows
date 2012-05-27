module Kjxtag
  module TagScore
    def self.load_scores(input_stream)
      ret = {}
      while line = input_stream.gets do
        line.chomp!
        record = line.split(/\t/)
        tag_id = record[0].to_i
        score = record[1].to_i
        ret[tag_id] = score
      end
      return ret
    end
  end
end