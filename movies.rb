require 'pg'
require 'rest-client'

conn = PGconn.open("dbname=movies_db port=5432")

def load_all(conn)

  movie_api = 'movies.api.mks.io/movies'
  actors_api = 'movies.api.mks.io/actors'
  get_m = RestClient.get(movie_api)
  movies = JSON.parse(get_m)
  get_a = RestClient.get(actors_api)
  actors = JSON.parse(get_a)

  movies.each do |x|

    m_name = conn.escape(x["title"])
    m_id = x["id"]


    sql = 'INSERT INTO movies (id,name,actors) VALUES ($1, $2);'

    conn.exec_params(sql, [m_id, m_name])

  end

  actors.each do |x|

    a_name = conn.escape(x["name"])
    a_id = x["id"] 

    sql = 'INSERT INTO actors (id,name,actors) VALUES ($1, $2);'

    conn.exec_params(sql, [a_id, a_name])

  end

  # find relationships
  get_movie_actors = RestClient.get(movie_api + "/" + m_id.to_s + "/actors")
  current_actors = JSON.parse(get_movie_actors)

  current_actors.each do |x|

    #a_name = conn.escape(x["name"])
    #a_id = x["id"] 

    sql = 'INSERT INTO a_to_m (name,actors) VALUES ($1, $2);'

    conn.exec_params(sql, [a_id, a_name])

  end


end

load_all(conn)