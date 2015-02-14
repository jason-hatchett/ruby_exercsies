book = { :title => "Gourd of the Flies", :author => "J. W. Gourding"}

small_lib = [
  { :title => "Design Patterns", :authors => ["John Vlissides", "Richard Helm", "Ralph Johnson","Erich Gamma"]},
  { :title => "Patterns of Enterprise Application Architecture", :authors => ["Martin Fowler"]},
  { :title => "Domain Driven Design", :authors => ["Eric Evans"]}
]

volunteer = {
  :name =>"Alice",
  :age =>25,
  :phone_num =>"555-555-5555",
  :position =>"event receptionist"
}

state = {
  :name =>"Rhode Island",
  :abrv => "RI",
  :population => 1050292,
  :people =>"Rhode Islanders",
  :capital =>"Providence",
  :populous_cities => ["Providence","Warwick","Cranston"]
  :median_income_dollars => 54619,
  :governor => "Lincoln Chafee"
}

computer = {
	:owner => "Patrick",
	:make => "Apple",
	:model => "MacBook Air",
	:memory => "256 GB SSD",
	:ram_gb => 8,
	:display => "Retina",
	:processor => "Intel i7",
	:software => ["iPhoto", "Safari", "iMovie", "iMessage"]
}

dogs = [
	{:name => "Maple", :info => "brown pitbull", :fav_game => "tug-o-war", :loves => "swimming in the lake"},
	{:name => "Atlas", :info => "super energetic boxer", :fav_game => "fetch", :loves => "swimming in the lake"}
]

restaurant = {
	:name => "Patrick's Pizza Place",
	:location => "716 Congress",
	:health_score => 100,
	:dishes = [
		:appetizers => [
			"mozarella sticks",
			"calzone",
			"garlic knots"
			],
		:entrees => [
			"chicken parmigiana",
			"slice of pizza",
			"spaghetti & eggplant"
			],
		:desserts => [
			"tiramisu" 
			"cannoli", 
			"cheesecake"
		]
	]
}

class Restauraunt

	def initialize(name,location,health_score)
		@name = name
		@location = location
		@health_score = health_score
		@menu = [
			:appetizers => [
			"mozarella sticks",
			"calzone",
			"garlic knots"
			], 
			:entrees => [
			"chicken parmigiana",
			"slice of pizza",
			"spaghetti & eggplant"
			], 
			:desserts => [
			"tiramisu" 
			"cannoli", 
			"cheesecake"
			]
		]
	end
end


## exercises part 2

class Recipes


    def initialize
      @items = []
    end

    def add_item(item)
        @items << item
    end

    def view_items
        @item.each {|x| puts x, "\n"}
    end

end


class Item


    def initialize(name, num_served)
      @name = name
      @num = num_served
      @ingredients = []
    end

    def add_ingredient(ing)
        @ingredidents << ing
    end

    def view_ingredients
        @ingredients.each {|x| puts x, "\n"}
    end

end