# -*- coding: utf-8 -*-
STDERR.puts "[#{Time.now.strftime '%Y-%m-%d %H:%M:%S'}] (INFO) ruby #{$0} #{ARGV.join ' '}"

require "kjxtag"

tags_path = ARGV.shift
keywords_path = ARGV.shift

Kjxtag::TagExtract.output_tag_id_weights(STDOUT, tags_path, keywords_path)
