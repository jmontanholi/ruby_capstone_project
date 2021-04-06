require 'nokogiri'
require 'httparty'

class Scraper 
  attr_reader :url, :game_name

  def initialize(game_name)
    @game_name = game_name
    @url = "https://www.microsoft.com/en-us/search/shop/games?q=#{game_name}"
  end

  def parsing(url)
    unparsed_url = HTTParty.get(url)
    Nokogiri::HTML(unparsed_url)
  end

  def scrape
    parsed_page = parsing(@url)
  end
end
