class NYTimes
  attr_reader :url, :nytimes_data
  
  def initialize(runner_obj)
    @url = "http://api.nytimes.com/svc/topstories/v1/nyregion.json?api-key=1d36eb3f290115cc0f7f618d5da6bdfa:8:72707894"
    @nytimes_data = JSON.load(open(@url))
    @runner_obj = runner_obj
    news
  end

  def news
    i = 0
    while i < 10
      puts "#{i+1}. #{@nytimes_data["results"][i]["title"]}"
      i += 1
    end
    pick_story
  end

  def pick_story
    puts "Which headline would you like to know more about? Please enter the number: "
    valid = (1..10).to_a
    num = gets.chomp
    if num == "help"
      help
    elsif num == "exit"
      exit
    else
      num = num.to_i
    end
    if valid.include?(num) == false 
      puts "Invalid input"
      pick_story
    end
    puts nytimes_data["results"][num - 1]["abstract"]
    puts "Would you like to view another headline in depth?(Y/N)"
    ans = gets.chomp.downcase
    if ans == "y"
      pick_story
    elsif ans == "n"
      switch_class
    else
      help
    end
  end

  def switch_class
    puts "To return to main menu type 'main' or to view the weather forecast type 'weather':"
    input = gets.chomp.downcase
    if input == "main"
      @runner_obj.call
    elsif input == "weather"
      YahooAPI.new(@runner_obj)
    elsif input == "exit"
      exit
    elsif input == "help"
      help
    else
      self.pick_story
    end
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'weather' to learn the forecast for the next 5 days"
    puts "Type 'main' to return to the main menu"
    switch_class
  end

  def nombre
    @runner_obj.name
  end

  def exit
    abort("Farewell #{nombre}")
  end

end
