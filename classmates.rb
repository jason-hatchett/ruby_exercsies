require 'pg'

conn = PGconn.open("dbname=classmates_db port=5432")

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
  
  mystr = columns.join(",")
  
  return mystr
end


#conn.exec("INSERT INTO classmates (#{get_columns()}) VALUES (\'Jason\',\'Hatchett\',\'@Jason_Hatchett\')")

def insert(conn, table, columns, vals)
  #vals should be separated with single quotes and delimiters ex: \'Jason\',\'Hatchett\',\'@Jason_Hatchett\'

  conn.exec("INSERT INTO #{table} (#{columns}) VALUES (#{vals})")
end


def view_all(conn, table)

  res = conn.exec("SELECT * FROM #{table}")
  res.each do |row|
    puts '|'
      row.each do |col|
        print col
      end
  end
  puts ''

end

values_insert = "\'Fred\',\'Fredrickson\',\'@frad\'"
#insert(conn,'classmates', get_columns(conn, 'classmates'), values_insert)

#view_all(conn,'classmates')

def delete(conn, table, column, value)

  conn.exec("DELETE FROM #{table} WHERE #{column} = #{value}")

end

#delete(conn,'classmates', 'twitter', '\'@al_jo\'')

def update(conn, table, column, new_value, old_value)

  conn.exec("UPDATE #{table} SET #{column} = #{new_value} WHERE #{column} = #{old_value}")

end

update(conn,'classmates', 'first_name', '\'Franz\'', '\'Fred\'')
