def fill(pointX, pointY, newVal)
  value = @item[pointX][pointY]

  @item[pointX][pointY] = newVal
  #fill sides if possible
  if (pointX-1 >= 0 && @item[pointX-1][pointY] == value)
    fill(pointX-1, pointY, newVal)
  end

  if (pointX+1 < @x_length && @item[pointX+1][pointY] == value)
    fill(pointX+1, pointY, newVal)
  end

  if (pointY-1 >= 0 && @item[pointX][pointY-1] == value)
    fill(pointX, pointY-1, newVal)
  end

  if (pointY+1 < @y_length && @item[pointX][pointY+1] == value)
    fill(pointX, pointY+1, newVal)
  end
end


@item = File.readlines('floodfill_test.txt').map do |line|
  line.split("\n").first.split('')
end

size = @item.shift(1).first.join('').split(' ')
@y_length = Integer(size[0])
@x_length = Integer(size[1])
@point = @item.pop(1).first.join('').split(' ')

@item.each {|x| puts x.join}
puts "           "
puts "RESULT:"
puts "           "

fill(Integer(@point[1]),Integer(@point[0]),@point[2])

@item.each {|x| puts x.join}