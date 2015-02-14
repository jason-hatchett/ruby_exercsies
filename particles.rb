### Program Description:
### http://www.reddit.com/r/dailyprogrammer/comments/1rdtky/111113_challenge_142_easy_falling_sand/
###

item = File.readlines('particle_test.txt').map do |line|
  line.split("\n").first.split('')
end

size = Integer(item.shift(1).first.first)

item.each {|x| puts x.join}
puts "@@@@@@"
world = item.transpose


final = world.each do |column|
  column = column.each_with_index.map do |zone, i|
    if (i < size && zone == ' ' && column[i-1] == '.')
      column[i-1] = ' '
      column[i] = '.'
    end
  end
end

final.transpose.each {|x| puts x.join}
