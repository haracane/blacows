module Kjxtag
  module Load
    def self.load_tags_hash(input_path)
      ret = {}
      open(input_path) do |f|
        while line = f.gets do
          line.chomp!
          record = line.split(/\t/)
          ret[record[1]] = record[0]
        end
      end
      return ret
    end
  end
end