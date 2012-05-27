
key_index = 0
count_index = -1
to_val = "1"

while true do
  case ARGV[0]
  when "--to"
    ARGV.shift
    to_val = ARGV.shift
  else
    break
  end
end

while line = STDIN.gets do
  line.chomp!
  line.gsub!(/-?[0-9]+$/, to_val)
  STDOUT.puts line
end
