require 'open-uri'
require 'nokogiri'
require 'colorize'
require 'colorized_string'
require 'tty'

class Cli

  def run
      font = TTY::Font.new(:standard)
      pastel = Pastel.new
      puts font.write("The Mountain Project")
      puts "|><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><|".colorize(:white)
      puts pastel.decorate("Hello and welcome to the Mountain Project CLI! Your number one place for boulder routes at Dougs Roof.", :white, :bold)
      puts pastel.decorate("Type 'enter' to continue or 'exit!' to leave the program.", :white, :bold)
      input = gets.chomp
    if input == "enter"
      puts pastel.decorate('Here are the bouldering problems available to you!', :bold)
      Scraper.scrape_mountain_project
      list_of_climbs
      menu
    elsif input == "exit!"
      puts "Thanks for stopping by.".colorize(:light_blue)
    else
      run
    end
  end

  def list_of_climbs
    pastel = Pastel.new
    Climb.all.each.with_index(1) do |climb, i|
    puts pastel.decorate("#{i}. #{climb.name}, #{climb.difficulty}", :white)
  end
  end

  def menu
    pastel = Pastel.new
    puts pastel.decorate("Select a climb by typing in it's number:", :bold)
    input = gets.chomp
      climb = Climb.all[input.to_i - 1]
    if !climb
      puts "I didn't recognize that."
      puts "Please enter a valid number."
      menu
    else
      Scraper.scrape_details(climb)
      puts pastel.decorate("#{climb.type}", :white)
      puts pastel.decorate("Star Rating#{climb.star_rating}.", :white)
      puts pastel.decorate("Type 'enter' to select another climb or 'exit!' to leave the program.", :white, :bold)
      input = gets.chomp
    if input == "enter"
      puts pastel.decorate("You're becoming a pro. You know the drill.", :bold)
      list_of_climbs
      menu
    elsif input == "exit!"
      puts "Thanks for stopping by. May the Sharma force be with you.".colorize(:light_blue)
    else
      run
    end
    end
  end
end
