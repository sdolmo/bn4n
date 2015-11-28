require 'pry'

class YahooAPI
  attr_reader :url, :forecast_data

  def initialize(runner_obj)
    @url = "https://query.yahooapis.com/v1/public/yql?q=select%20item.forecast%20from%20weather.forecast%20where%20woeid%20%3D%202459115&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    @forecast_data = JSON.load(open(@url))
    @runner_obj = runner_obj
    forecast
  end

  def forecast
    puts "The forecast for the next 5 days is:"
    @forecast_data["query"]["results"]["channel"].each do |forecast_hash|
      puts "#{forecast_hash["item"]["forecast"]["day"]} #{forecast_hash["item"]["forecast"]["date"]} is #{forecast_hash["item"]["forecast"]["text"]}, with a high of #{forecast_hash["item"]["forecast"]["high"]} and a low of #{forecast_hash["item"]["forecast"]["low"]}." 
    end 
    switch_class
  end

  def switch_class
    puts "To return to the main menu type 'main' or to view the news type 'news':"
    input = gets.chomp.downcase
    if input == "main"
      @runner_obj.call
    elsif input == "news"
      NYTimes.new(@runner_obj)
    elsif input == "exit"
      exit
    else
      help
    end
  end

  def nombre
   @runner_obj.name
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'news' to learn the top 5 news stories of the day"
    switch_class
  end

  def exit
    abort("Farewell #{nombre}")
  end

end

