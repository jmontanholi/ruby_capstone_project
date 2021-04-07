require 'nokogiri'
require 'httparty'
require 'pry'
require 'rainbow'
require './lib/scrap_logic'

def greeter
  puts Rainbow('Welcome to the Microsoft Store Scraper. To start press enter.').cyan
  gets.chomp
end
greeter

end_parameter = String.new
until end_parameter == 'exit'
  puts Rainbow('Please insert the name of the game you want to search for. Please use no accents, e.g. "~"').cyan
  game_name = gets.chomp.to_s
  if !game_name.ascii_only?
    until game_name.ascii_only? && game_name.match(/\w{3,}/i)
      puts Rainbow('Please enter a valid name with no accents, e.g. "~"').red
      game_name = gets.chomp.to_s
    end
  end
  puts search(game_name)
  puts Rainbow('If you want to search again press enter, if you want to exit please insert "exit"').cyan
  end_parameter = gets.chomp.to_s.downcase
end

