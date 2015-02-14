 require 'rest-client'


# "critics.api.mks.io/restaurants"

def rated8(myURL)

    @url = myURL
    response = RestClient.get(@url)
    ratings = JSON.parse(response)

    ratings.each do |x|
    
      puts "#{x["rating"]} - #{x["venue"]}" if (x["rating"].to_i >= 8)

    end
    
end

def austin_name(myURL)

    @url = myURL
    response = RestClient.get(@url)
    ratings = JSON.parse(response)

    puts "Austin restaurants:"

    ratings.each do |x|
    
      puts x["venue"] if (x["venue"].downcase.include?("austin"))

    end
    
end

def pop_genres(myURL)

    @url = myURL
    response = RestClient.get(@url)
    ratings = JSON.parse(response)

    counts = []

    ratings.each do |x|
      if  h = counts.find { |h| h["genre"] == x["genre"].downcase.sub('-', '').strip }
        h["count"] += 1
      else
        counts.push({"genre" => x["genre"].downcase.sub('-', '').strip, "count" => 1})

      end
    end

    #sort counts
    sorted = counts.sort_by { |k| k["count"] }.reverse

    puts "Popular Movie Genres:"

    sorted[0..2].each do |i|
    
      puts "#{i["genre"]} - #{i["count"]} reviews"

    end
    
end

def top_genres(myURL)

    @url = myURL
    response = RestClient.get(@url)
    ratings = JSON.parse(response)

    counts = []

    ratings.each do |x|
      if  h = counts.find { |h| h["genre"] == x["genre"].downcase.sub('-', '').strip }
        h["count"] += 1
        h["rating"] = ((h["rating"].to_f * (h["count"]-1) + x["rating"].to_f) / (h["count"])).to_s
      else
        counts.push({"genre" => x["genre"].downcase.sub('-', '').strip, "count" => 1, "rating" => x["rating"]})

      end
    end

    #sort counts
    sorted = counts.sort_by { |k| k["rating"] }.reverse

    puts "Top Movie Genres:"

    sorted[0..2].each do |i|
    
      puts "#{i["genre"]} - #{i["count"]} reviews"

    end
    
end


def cheese_info(myURL)

    @url = myURL
    response = RestClient.get(@url)
    ratings = JSON.parse(response)

    ratings.each do |i|
    
      puts "#{i["cheese"]}: #{i["comment"]} --#{i["reviewer"]}"

    end
    
end

#rated8("critics.api.mks.io/restaurants")
austin_name("critics.api.mks.io/restaurants")
#pop_genres("critics.api.mks.io/movie-genres")
#top_genres("critics.api.mks.io/movie-genres")
#cheese_info("critics.api.mks.io/cheeses")