require 'nokogiri'
require 'httparty'
require 'pry'
require 'rainbow'
require './lib/scrap_logic.rb'

def greeter 
  puts Rainbow('Welcome to the Microsoft Store Scraper. To start press enter.').magenta
  gets.chomp
end

def search 
  puts Rainbow('Please insert the name of the game you want to search for. Please use no accents, e.g. "~"').magenta
  game_name = gets.chomp.to_s
  until game_name.match(/\w{3,}/i)
    puts Rainbow('Please enter a valid name with no accents, e.g. "~"').red
    game_name = gets.chomp.to_s
  end

  scraper = Scraper.new(game_name)
  puts scraper.scrape
end

greeter
search