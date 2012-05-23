# -*- coding: utf-8 -*-
require "kjxtag"

EXTRACT_ALL = 0
EXTRACT_TAG = 1

extract_mode = EXTRACT_ALL # 1

while true do
  case ARGV[0]
  when "--all"
    extract_mode = EXTRACT_ALL # 1
    ARGV.shift
  when "--tag"
    extract_mode = EXTRACT_TAG # 1
    ARGV.shift
    tags_path = ARGV.shift
    tags_hash = Kjxtag::Load.load_tags_hash(tags_path)
  else
    break
  end
end

mecab = MeCab::Tagger.new()

while line = STDIN.gets do
  line.chomp!
  record = JSON.parse(line)
  entry_id = record["id"]
  node = mecab.parseToNode(record["description"])

  tag_count_hash = {}
  case extract_mode
  when EXTRACT_ALL
    while node do
      surface = node.surface
      feature = CSV.parse_line(node.feature)
      hinshi = feature.shift
      case hinshi
      when "名詞"
        length = surface.split("").length
        if 1 < length then
          tag_count_hash[surface] = (tag_count_hash[surface] || 0 ) + 1
        end
      end
      node = node.next
    end
  when EXTRACT_TAG
    while node do
      surface = node.surface
      tag_id = tags_hash[surface]
      if tag_id then
        key = tag_id
        key = surface
        tag_count_hash[key] = (tag_count_hash[key] || 0 ) + 1
      end
      node = node.next
    end
  end
  tag_count_hash.keys.sort.each do |key|
    STDOUT.puts "#{entry_id}\t#{key}\t#{tag_count_hash[key]}"
  end
end

