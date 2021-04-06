require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 
  attr_reader :url, :game_name, :results_number, :parsed_page, :games

  def initialize(game_name)
    @game_name = game_name
    @url = "https://www.microsoft.com/en-us/search/shop/games?q=#{game_name}"
  end

  def parsing(url)
    page = Nokogiri::HTML(URI.open(url))
  end

  def scrape
    parsed_page = parsing(@url)
    games = parsed_page.css('h3.c-subheading-6')
    results_number = games.count
  end

  def create_game_hash
  end
end

test = Scraper.new('sekiro')
binding.pry
puts 'somethign'