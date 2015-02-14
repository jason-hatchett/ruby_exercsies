class Ingredient
    attr_accessor :name
    attr_accessor :units
    

    def initialize(name, amt=nil, units= nil)
        @name = name
        @units = units
        if amt
             @amt = amt 
        end
        if units
             @units = units 
        end
       
    end

    def get_amt
        if @amt 
            return amt
        else
            return ""
        end
    end

    def get_units
        if @units 
            return @units
        else
            return ""
        end
    end
end


class Item
    attr_accessor :name, :num
    

    def initialize(name, num)
        @name = name
        @num = num
        @ingredients = []
    end

    def add_ingredient(ing)
        @ingredients.push(ing)
    end

    def view_ingredients
        @ingredients.each {|x| puts "#{x.get_amt}#{x.name}"}
    end

end

#as = Item.new("apple salad", 4)
#as.add_ingredient(Ingredient.new("mixed greens", "6 oz"))
#as.add_ingredient(Ingredient.new("honey mustard", "1 tbs"))
#as.add_ingredient(Ingredient.new("almonds", "2 tbs"))
#as.add_ingredient(Ingredient.new("apples", "4"))
#as.add_ingredient(Ingredient.new("salt and pepper"))

#as.view_ingredients


Recipes = {}
measures = ["oz", "tbs", "lbs", "cup"]
last_line_blank = false
current_item = ""
text=File.open('recipe_txt').read
text.each_line do |line|
    if current_item === "" || last_line_blank
        current_item = line
    elsif line[0,6] === "serves"
        s = line.split(" ")[1]
        Recipes = {current_item => Item.new(current_item, s)}
    elsif line === "\n\n"
        last_line_blank = true
    else
        if measures.include?(line.split(" ")[1])
            #add unit type + amt + name
            Recipes[current_item].add_ingredient(line[(line.split(" ")[1].length+line.split(" ")[0].length+2)..-1],(line.split(" ")[0]),(line.split(" ")[1]))
        elsif line.split(" ")[0].to_i.to_s == line.split(" ")[0] #is it an int?
            #add amt + name
            Recipes[current_item].add_ingredient(line.substring[(line.split(" ")[0].length+1),(line.split(" ")[0])])
        else #no amt
            #add name
            Recipes[current_item].add_ingredient(line.split(" ")[0])
        end
    end
end
