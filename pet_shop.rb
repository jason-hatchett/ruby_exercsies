require 'pg'
require 'rest-client'

conn = PGconn.open("dbname=petshop_db port=5432")

def create_items(conn)
      #getme = RestClient.get('pet-shop.api.mks.io/shops')
      #shops = JSON.parse(getme)

      #columns = shops[0].keys
      #mystr = columns.join(",")

      sql_shops = %q[ 
        CREATE TABLE IF NOT EXISTS Shops (
        id INTEGER NOT NULL PRIMARY KEY,
        name VARCHAR)
      ]

      sql_cats = %q[ 
        CREATE TABLE IF NOT EXISTS Cats (
        id INTEGER NOT NULL PRIMARY KEY,
        name VARCHAR,
        imageUrl VARCHAR,
        shop_id INTEGER REFERENCES Shops(id) )
      ]

      sql_dogs = %q[ 
        CREATE TABLE IF NOT EXISTS Dogs (
        id INTEGER NOT NULL PRIMARY KEY,
        name VARCHAR,
        imageUrl VARCHAR,
        happiness INTEGER,
        shop_id INTEGER REFERENCES Shops(id)  )
      ]


      conn.query(sql_shops)
      conn.query(sql_cats)
      conn.query(sql_dogs)
      
end

def load_shops(conn, api)
      getme = RestClient.get(api)
      items = JSON.parse(getme)
      columns = items[0].keys
      mystr = columns.join(",")
      beginning = "INSERT INTO shops (#{mystr}) VALUES "

      values_array = items.map do |item|
        item.values
      end

      values = values_array.map do |value_pair|
        value_pair.map! do |i|
          if i.is_a? Numeric
            i
          else
            "'#{i.gsub(/'/, '')}'"
          end
        end
        "(" + value_pair.join(",") + ")"
      end

      ending = values.join(",")

      sql = beginning + ending
      #puts sql
      conn.exec(sql)

end

def load_cats(conn, api)
      get_s = RestClient.get(api)
      shops = JSON.parse(get_s)

      get_col = get_columns(conn, "cats")

      l = (shops.length) - 1
      for shopId in 1..l
        get_cats = RestClient.get('pet-shop.api.mks.io/shops/' + shopId.to_s + '/cats')
        cats = JSON.parse(get_cats)

        #check for empty array
        if cats.empty? != true
            #columns = cats[i].keys
            #mystr = columns.join(",")
            #beginning = "INSERT INTO cats (#{mystr}) VALUES "

            values_array = cats.map do |item|
              item.values
            end
      
      
            values = values_array.map do |value_pair|
              value_pair.map! do |i|
                if i.is_a? Numeric
                  i
                elsif (i.is_a?(TrueClass) || i.is_a?(FalseClass))
                  i.to_s
                else
                  "'#{i.gsub(/'/, '')}'"
                end
              end
              "(" + value_pair.join(",") + ")"
            end


            for x in 0..(values_array.length - 1)
              columns = cats[x].keys
              mystr = columns.join(",")
              sorted_col = columns.sort
              mystr = columns.join(",")
              sorted_mystr = sorted_col.join(",").downcase
              puts "string: #{sorted_mystr}, columns: #{get_col}"
              if (sorted_mystr == get_col)

                sql = "INSERT INTO cats (#{mystr}) VALUES " + values[x] + ";"
                #puts sql
                conn.exec(sql)
              end
            end

          
      
        end

        #ending = values.join(",")
      
        #sql = beginning + ending
        #puts sql
        #conn.exec(sql)

      end
end

def load_dogs(conn, api)
      get_s = RestClient.get(api)
      shops = JSON.parse(get_s)

      get_col = get_columns(conn, "dogs")

      l = (shops.length) - 1
      for shopId in 1..l
        #puts "last shop: " + shopId
        get_dogs = RestClient.get('pet-shop.api.mks.io/shops/' + shopId.to_s + '/dogs')
        dogs = JSON.parse(get_dogs)

        #check for empty array
        if dogs.empty? != true
            #columns = dogs[i].keys
            #mystr = columns.join(",")
            #beginning = "INSERT INTO dogs (#{mystr}) VALUES "

            values_array = dogs.map do |item|
              item.values
            end
      
      
            values = values_array.map do |value_pair|
              value_pair.map! do |i|
                if i.is_a? Numeric
                  i
                elsif (i.is_a?(TrueClass) || i.is_a?(FalseClass))
                  i.to_s
                else
                  "'#{i.gsub(/'/, '')}'"
                end
              end
              "(" + value_pair.join(",") + ")"
            end


            for x in 0..(values_array.length - 1)
              columns = dogs[x].keys
              mystr = columns.join(",")
              sorted_col = columns.sort
              mystr = columns.join(",")
              sorted_mystr = sorted_col.join(",").downcase
              puts "string: #{sorted_mystr}, columns: #{get_col}"
              if (sorted_mystr == get_col)

                sql = "INSERT INTO dogs (#{mystr}) VALUES " + values[x] + ";"
                #puts sql
                conn.exec(sql)
              end
            end

          end
      
        end
end

def get_columns(conn, table)
  res = conn.exec("SELECT column_name
  FROM   information_schema.columns
  WHERE  table_name = \'#{table}\';")
  
  
  #return column names
  columns = []
    res.each do |row|
      #puts row["column_name"]
      columns.push(row["column_name"])
    end
  columns.sort!
  mystr = columns.join(",")
  #puts mystr
  return mystr
end

#create_items(conn)
#load_shops(conn,'pet-shop.api.mks.io/shops')
#load_cats(conn,'pet-shop.api.mks.io/shops')
#puts get_columns(conn,cats)
load_dogs(conn,'pet-shop.api.mks.io/shops')
#puts TrueClass.to_s
puts ''