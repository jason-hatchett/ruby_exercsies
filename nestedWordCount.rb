def nestedWordCount (wordList) 
 #sort wordList
 
  sortedList = wordList.sort{|a,b| b.length <=> a.length} #by length to smallest

 #array of hashes
  myNodes = []
 
 #loop through sortedList and try to add into list
 sortedList.each do |i|
  added = false;
   myNodes.each do |j| 
      if (j['word'].downcase.include?(i.downcase))
        j['counter'] += 1
        added = true
      end
   end
   if (added == false)
    myNodes.push({'word' => i, 'counter' => 1})
   end
 end

  sortans = myNodes.sort{|a,b| b['counter'] <=> a['counter']}
  value = sortans.first['word']

  return value
  
end

testarray = []
File.open("/home/jason/student-dev-box/javascript/wordz.txt", "r") do |f|
  f.each_line do |line|
    testarray.push(line)
  end
end

puts nestedWordCount(testarray)