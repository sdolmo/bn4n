class MorningCLI

  def initialize
   @name = "user"
  end

  def new_name
    puts "Hi. What's your name?"
    user_name = gets.chomp.capitalize
    if user_name != "Exit"
     @name = user_name
      call
    else
      abort("Farewell")
    end
  end

  def name
   @name
  end


  def call
    puts "Good morning #{name}. What would you like to learn, Weather or News?"
    get_input
  end

  def get_input
    input = gets.chomp.downcase
    if input == "help"
      help
    elsif input == "exit"
      abort("Farewell #{name}")
    elsif input == "news"
      news = NYTimes.new(self) 
    elsif input == "weather"
      weather = YahooAPI.new(self)
    else
      puts "Invalid input. Type help for more info or try again."
      call
    end
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'weather' to learn the forecast for the next 5 days"
    puts "Type 'news' to learn the top 5 news stories of the day"
    get_input
  end

end

