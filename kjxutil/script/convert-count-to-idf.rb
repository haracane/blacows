
key_index = 0
count_index = -1

n = 1
ratio = 256

while true do
  case ARGV[0]
  when "--ratio"
    ARGV.shift
    ratio = ARGV.shift.to_i
  when "--n"
    ARGV.shift
    n = ARGV.shift.to_i
  else
    break
  end
end

n = n.to_f

count_hash = {}

while line = STDIN.gets do
  line.chomp!
  record = line.split(/\t/)
  key = record[key_index]
  count = record[count_index].to_f
  idf = (Math.log(n/count) * ratio).to_i
  STDOUT.print key
  STDOUT.print "\t"
  STDOUT.puts idf
end

