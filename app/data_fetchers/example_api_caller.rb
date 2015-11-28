class Ny_times

  
# http://api.nytimes.com/svc/topstories/v1/nyregion.json?api-key=1d36eb3f290115cc0f7f618d5da6bdfa:8:72707894

  def initialize
    @url = "http://api.nytimes.com/svc/topstories/v1/nyregion.json?api-key=1d36eb3f290115cc0f7f618d5da6bdfa:8:72707894"
    @nytimes_data = JSON.load(open(@url))
  end

  def ny_top_stories
    i = 0
    while i < 5
      puts "#{i+1}. #{nytimes_data["results"][i]["titles"]}"
      i += 1
    end
    pick_story
  end

  def pick_story
    puts "Which headline would you like to know more about? Please enter the number: "
    num = gets.chomp.to_i 
    puts nytimes_data["results"][num - 1]["abstract"]
  end

end
