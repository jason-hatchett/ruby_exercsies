#   Write a method that takes a two-argument predicate,
#    a value, and a list; 
#   and returns a new list where the value is inserted 
#   between every two items that satisfy the predicate.

def weird_insert(operator, value, list)

  list.each_with_index do |item, index|
    if (item == value || (index+1) == list.size)
      #do nothing
    elsif (item.send(operator, list[index+1]))
      list.insert(index+1, value)
    end
  end

  return list
end

p weird_insert("<", :less, [1, 6, 7, 4, 3])

