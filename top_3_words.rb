# Write a function that, given a string of text
# (possibly with punctuation and line-breaks),
# returns an array of the top-3 most occurring words, 
# in descending order of the number of occurrences.


def top_3_words (text)
  word_hash = Hash.new(0)
  len = text.length
  while (len > 0)

    nextIndex = text.index(' ')

    if (nextIndex == nil)
      nextIndex = text.length
    else
      nextIndex += 1
    end

    word = text.slice!(0, nextIndex).strip.downcase
    word_hash[word] += 1

    len = text.length

  end

  array = word_hash.sort_by{ |item, count| count}.last(3).reverse
  
  return array.map{|item| item[0]}
end

p top_3_words ("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e")