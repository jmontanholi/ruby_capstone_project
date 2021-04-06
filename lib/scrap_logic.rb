require 'nokogiri'
require 'httparty'
require 'pry'
require 'rainbow'

class Scraper
  attr_reader :url, :game_name

  def initialize(game_name)
    @game_name = game_name
    @url = "https://www.microsoft.com/en-us/search/shop/games?q=#{game_name.gsub(' ', '%20')}"
  end

  def parsing(url)
    page = HTTParty.get(url)
    Nokogiri::HTML(page.body)
  end

  def scrape
    parsed_page = parsing(@url)
    games = parsed_page.css('div.m-channel-placement-item')

    create_game_hash(games)
  end

  def create_game_hash(games)
    games.map do |game|
      begin
        "#{Rainbow("\nName: ").cyan}#{Rainbow(game.css('h3.c-subheading-6').children[0].text.to_s).green}
#{Rainbow('Price: ').cyan}" \
        "#{Rainbow(game.css('div.c-price').children[1].children[0].text.gsub(' ', '').gsub("\r", '').gsub("\n",
                                                                                                          '')).green}
#{Rainbow('Link: ').cyan}#{Rainbow("https://www.microsoft.com#{game.css('a').attr('href').value}").green}"
      rescue StandardError
        "#{Rainbow("\nName: ").cyan}#{Rainbow(game.css('h3.c-subheading-6').children[0].text.to_s).green}
#{Rainbow('Price: ').cyan}" \
        "#{Rainbow('Nothing specified, check the link for more informations').green}
#{Rainbow('Link: ').cyan}#{Rainbow("https://www.microsoft.com#{game.css('a').attr('href').value}").green}"
      end
    end
  end
end
