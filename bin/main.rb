require 'nokogiri'
require 'httparty'
require 'pry'
require 'rainbow'
require './lib/scrap_logic.rb'

def greeter 
  puts 'Welcome to the Microsoft Store Scraper. To start press enter.'
  gets.chomp
end

def search 
  puts 'Please insert the name of the game you want to search for.'
  game_name = gets.chomp.to_s
  until game_name.match(/\w{3,}/i)
    puts "Please enter a valid name"
    game_name = gets.chomp.to_s
  end

  scraper = Scraper.new(game_name)
  puts scraper.scrape
end

greeter
search