require 'rainbow'

class MastermindGame
  attr_accessor :gameboard
  attr_accessor :result_array
  def initialize
    @gameboard = Array.new
    @result_array = Array.new
    @turn_count = 1
    @result_array[0] = ['0', '0', 'x', 'x']
  end

  def print_board
    puts "-----------------------------------"
    @gameboard.each_with_index do |gameboard, turn| 
        puts "#{@gameboard[turn][0]} | #{@gameboard[turn][1]} | #{@gameboard[turn][2]} | #{@gameboard[turn][3]} | -- | #{@result_array[turn][0]} | #{@result_array[turn][1]} | #{@result_array[turn][2]} | #{@result_array[turn][3]}"
    end
    puts "-----------------------------------"
  end

  def user_input
    puts 'Make your 4-peg guess from 6 colors (red (r), green (g), yellow (y), blue (b), magenta (m), and aqua (a)) separated by a comma.'
    user_input_raw = gets.chomp.downcase.gsub(/\s+/, "")
    @user_input = user_input_raw.split(',')
    update_board
  end

  def update_board
    # I love you. You're doin such a good job :3 
    # - Cat #
    @display_array = Array.new
    @user_input.each do |color|
      if color == 'red' || color == 'r'
        @display_array << Rainbow('O').red
      elsif color == 'green' || color == 'g'
        @display_array << Rainbow('O').green
      elsif color == 'yellow' || color == 'y'
        @display_array << Rainbow('0').yellow
      elsif color == 'blue' || color == 'b'
        @display_array << Rainbow('0').blue
      elsif color == 'magenta' || color == 'm'
        @display_array << Rainbow('0').magenta
      elsif color == 'aqua' || color == 'a'
        @display_array << Rainbow('0').aqua
      else
        puts "Please select colors from the list of six."
        user_input
      end
    end
    @gameboard << @display_array
    @result_array << ['0', '0', 'x', 'x']
    print_board
    @turn_count += 1
  end

  def play_game
    while @turn_count < 13
      user_input
    end
  end
end

new_game = MastermindGame.new
new_game.play_game