
key_index = 0
count_index = -1

while true do
  case ARGV[0]
  when "--key"
    ARGV.shift
    key_index = ARGV.shift.to_i
  else
    break
  end
end

count_hash = {}

while line = STDIN.gets do
  line.chomp!
  record = line.split(/\t/)
  key = record[key_index]
  count = record[count_index].to_i
  count_hash[key] = (count_hash[key] || 0) + count
end

count_hash.each do |key, count|
  STDOUT.print key
  STDOUT.print "\t"
  STDOUT.puts count
end
