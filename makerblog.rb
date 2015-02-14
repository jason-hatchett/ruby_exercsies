require 'rest_client'
require 'json'

module MakerBlog
  class Client
    def list_posts
      response = RestClient.get('http://makerblog.herokuapp.com/posts', accept: 'application/json')
      posts = JSON.parse(response.body)
      posts.each do |post|
        # your code goes here!
        puts "Id: #{post["id"]}"
        puts "#{post["name"]}: #{post["content"]}"
        puts "URL: #{post["url"]}"
        puts ""
      end
    end

    def show_post(id)
      # hint: URLs are strings and you'll need to append the ID
      @id = id
      url = "http://makerblog.herokuapp.com/posts/#{@id}"
      response = RestClient.get(url, accept: 'application/json')
      post = JSON.parse(response.body)

      puts "Id: #{post["id"]}"
      puts "#{post["name"]}: #{post["content"]}"
      puts "Last Updated: #{post["updated_at"]}"
    end

    def create_post(name, title, content)
      url = 'http://makerblog.herokuapp.com/posts'
      payload = {:post => {'name' => name, 'title' => title, 'content' => content}}

      response = RestClient.post(url, JSON.generate(payload), accept: 'application/json', content_type: 'application/json')

     # convert then display your results here
      post = JSON.parse(response.body)

      puts "Id: #{post["id"]}"
      puts "#{post["name"]}: #{post["title"]}: #{post["content"]}"
      puts "Last Updated: #{post["updated_at"]}"
    end

    def edit_post(id, options = {})
      @id = id
      url = "http://makerblog.herokuapp.com/posts/#{@id}"
      params = {}

      # can't figure this part out? Google "ruby options hash"
      params[:name] = options[:name] unless options[:name].nil?
      params[:title] = options[:title] unless options[:title].nil?
      params[:content] = options[:content] unless options[:content].nil?

      response = RestClient.put(url, { post: params }, accept: 'application/json', content_type: 'application/json')

      # you know the drill, convert the response and display the result nicely
      post = JSON.parse(response.body)

      puts "Id: #{post["id"]}"
      puts "#{post["name"]}: #{post["title"]}: #{post["content"]}"
      puts "Last Updated: #{post["updated_at"]}"
    end

    def delete_post(id)
      @id = id
      url = "http://makerblog.herokuapp.com/posts/#{@id}"
      response = RestClient.delete(url, accept: 'application/json')
      puts response.code
    end

  end
end


client = MakerBlog::Client.new
#client.list_posts
#client.show_post(19138)
#client.create_post("Hey Hey", "You You", "Some song by avril")
#client.edit_post(19730, {:name => "Sk8er"})
client.delete_post(19730)
