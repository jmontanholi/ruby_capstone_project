require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 
  attr_reader :url, :game_name

  def initialize(game_name)
    @game_name = game_name
    @url = "https://www.microsoft.com/en-us/search/shop/games?q=#{game_name.gsub(' ', "%20")}"
  end

  def parsing(url)
    Nokogiri::HTML(URI.open(url))
  end

  def scrape
    parsed_page = parsing(@url)
    games = parsed_page.css('h3.c-subheading-6')
    results_number = games.count

    create_game_hash(games)
  end

  def create_game_hash(games)
    parsed_page = parsing(@url)
    games = parsed_page.css('div.m-channel-placement-item')
    games.map do |game|
      begin
        puts "\nName: #{game.css('h3.c-subheading-6').children[0].text}\nPrice: #{game.css('div.c-price').children[1].children[0].text.gsub(' ', '').gsub("\r", '').gsub("\n",'')}\nLink: https://www.microsoft.com#{game.css('a').attr('href').value}"
      rescue 
        puts "\nName: #{game.css('h3.c-subheading-6').children[0].text}\nPrice: Nothing specified, check link for more options\nLink: https://www.microsoft.com#{game.css('a').attr('href').value}"
      
      end
    end
  end

end

test = Scraper.new('call of duty')
test.scrape
