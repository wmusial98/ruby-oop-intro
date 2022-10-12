require 'rainbow'

class MastermindGame
  attr_accessor :gameboard
  attr_accessor :result_array
  def initialize
    @gameboard = Array.new
    @result_array = Array.new
    @turn_count = 1
    @computer_code = Array.new
    @guess = Array.new
    @checkmark = "\u2713"
    @winner = nil
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
    if @user_input.length != 4 
      user_input
    end
    update_board(@user_input)
  end

  def update_board(input_array)
    # I love you. You're doin such a good job :3 
    # - Cat #
    @guess = []
    @display_array = Array.new
    input_array.each do |color|
      if color == 'red' || color == 'r'
        @display_array << Rainbow('O').red
        @guess << 'red'
      elsif color == 'green' || color == 'g'
        @display_array << Rainbow('O').green
        @guess << 'green'
      elsif color == 'yellow' || color == 'y'
        @display_array << Rainbow('0').yellow
        @guess << 'yellow'
      elsif color == 'blue' || color == 'b'
        @display_array << Rainbow('0').blue
        @guess << 'blue'
      elsif color == 'magenta' || color == 'm'
        @display_array << Rainbow('0').magenta
        @guess << 'magenta'
      elsif color == 'aqua' || color == 'a'
        @display_array << Rainbow('0').aqua
        @guess << 'aqua'
      else
        puts "Please select colors from the list of six."
        user_input
      end
    end
    @gameboard << @display_array
    @turn_count += 1
  end

  def get_computer_code
    color_array = ['red', 'green', 'yellow', 'blue', 'magenta', 'aqua']
    4.times do @computer_code << color_array.sample; end
  end

  def sort_turn_result
    @sorted_turn = @turn_result.sort{|a,b| b <=> a}
  end

  def compare_code_guess
    @turn_result = []
    temp_comp_code = @computer_code.map{|element| element}
    @guess.each_with_index do |guess, index|
      if guess == temp_comp_code[index]
        @turn_result << @checkmark
        temp_comp_code[index] = nil
      elsif temp_comp_code.include?(guess)
        @turn_result << 'o'
        temp_comp_code[temp_comp_code.index guess] = nil
      else
        @turn_result << 'X'
      end
    end
    check_winner
    p @turn_result
    sort_turn_result
    p @sorted_turn
    p @winner
    @result_array << @sorted_turn
  end

  def check_winner
    if @turn_result.uniq.size == 1 && @turn_result[0] == @checkmark
      @winner = 'the player'
    elsif @turn_count > 12
      @winner = 'the computer'
    end
  end

  def play_vs_pc_codemaker
    get_computer_code
    until @turn_count > 12 || @winner
      user_input
      compare_code_guess
      print_board
    end
    puts "The winner is #{@winner}!"
  end
end

new_game = MastermindGame.new
new_game.play_vs_pc_codemaker