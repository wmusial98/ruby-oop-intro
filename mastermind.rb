require 'rainbow'

module MastermindGame
  attr_accessor :gameboard
  attr_accessor :result_array
  def begin
    @gameboard = Array.new
    @result_array = Array.new
    @turn_count = 1
    @code_to_break = Array.new
    @guess = Array.new
    @winner = nil
    @checkmark = "\u2713"
    @number_code
    @code_pool = Array.new
  end

  def print_board
    puts "-----------------------------------"
    @gameboard.each_with_index do |gameboard, turn| 
        puts "#{@gameboard[turn][0]} | #{@gameboard[turn][1]} | #{@gameboard[turn][2]} | #{@gameboard[turn][3]} | -- | #{@result_array[turn][0]} | #{@result_array[turn][1]} | #{@result_array[turn][2]} | #{@result_array[turn][3]}"
    end
    puts "-----------------------------------"
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

  def user_input
    puts 'Make your 4-peg code from 6 colors (red (r), green (g), yellow (y), blue (b), magenta (m), and aqua (a)) separated by a comma.'
    user_input_raw = gets.chomp.downcase.gsub(/\s+/, "")
    @user_input = user_input_raw.split(',')
    if @user_input.length != 4 
      @user_input = []
      user_input
    end
  end

  def sort_turn_result
    @sorted_turn = @turn_result.sort{|a,b| b <=> a}
  end

  def check_winner
    if @turn_result.uniq.size == 1 && @turn_result[0] == @checkmark
      @winner = 'the player'
    elsif @turn_count > 12
      @winner = 'the computer'
    end
  end
end

module ComputerCodemakerGame
  def get_computer_code
    color_array = ['red', 'green', 'yellow', 'blue', 'magenta', 'aqua']
    4.times do @code_to_break << color_array.sample; end
  end

  def compare_code_guess
    @turn_result = []
    temp_comp_code = @code_to_break.map{|element| element}
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
    sort_turn_result
    @result_array << @sorted_turn
  end
end

class VsComputerCodemaker
  include MastermindGame
  include ComputerCodemakerGame
  def initialize
    puts Rainbow("In this mode, you will try to guess a computer-generated code in 12 or less turns. There may be duplicate colors, but there are no blank spots. The computer will provide feedback based on your guess, giving you a #{"\u2713"} on a correct color and location, a 'o' for a correct color, and an 'X' for a completely incorrect guess. The feedback is given is not ordered in the sequence of your guess - good luck!").white.bg(:black)
  end

  def play_vs_pc_codemaker
    until @turn_count > 12 || @winner
      user_input
      update_board(@user_input)
      compare_code_guess
      print_board
    end
    puts "The winner is #{@winner}!"
  end
end

module ComputerCodebreakerGame
  def create_code_pool
    number_codes = [0, 1, 2, 3, 4, 5]
    number_codes.repeated_permutation(4) {|permutation| @code_pool << permutation}.pop
    @first_comp_guess = [0, 0, 1, 1]
  end
  
  def get_player_code
    user_input
    @code_to_break = @user_input.map {|element| element}
    code_to_numbers
  end

  def code_to_numbers
    # 0 = red, 1 = green, 2 = yellow, 3 = blue, 4 = magenta, 5 = aqua
    @number_code = []
    @code_to_break.each do |color|
      if color == 'red' || color == 'r'
        @number_code << 0
      elsif color == 'green' || color == 'g'
        @number_code << 1
      elsif color == 'yellow' || color == 'y'
        @number_code << 2
      elsif color == 'blue' || color == 'b'
        @number_code << 3
      elsif color == 'magenta' || color == 'm'
        @number_code << 4
      elsif color == 'aqua' || color == 'a'
        @number_code << 5
      end
    end
  end

  def check_matches
  end
end

class VsComputerCodebreaker
  include MastermindGame
  include ComputerCodebreakerGame
  def initialize
    puts Rainbow("In this mode, the computer will try to guess a code you make in 12 or less turns. You can use duplicate colors, but don't use any blank spots. The game will automatically provide feedback for the computer until the game is over, so sit back and watch the computer do it's magic!").white.bg(:black)
  end

  def play_vs_pc_codebreaker
    create_code_pool
    get_player_code
    check_matches
  end
end

puts 'Welcome to Mastermind! Select a mode:'
puts '[1] Play against computer codemaker'
puts '[2] Play against computer codebreaker'
game_choice = gets.chomp.to_i
if game_choice == 1
  new_game = VsComputerCodemaker.new
  new_game.begin
  new_game.play_vs_pc_codemaker
elsif game_choice == 2
  new_game = VsComputerCodebreaker.new
  new_game.begin
  new_game.play_vs_pc_codebreaker
end
