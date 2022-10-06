class TicTacToe
  def initialize
    puts 'What is the name of the first player?'
    @p1_name = gets.chomp
    puts 'What is the name of the second player?'
    @p2_name = gets.chomp
    @temp_name = nil

    @game_board = %w[1 2 3 4 5 6 7 8 9]
    @turn_count = 1
    @player_choice = nil
    @winner = nil
  end

  private

  def update_board
    puts "#{@game_board[0]} | #{@game_board[1]} | #{@game_board[2]}"
    puts "#{@game_board[3]} | #{@game_board[4]} | #{@game_board[5]}"
    puts "#{@game_board[6]} | #{@game_board[7]} | #{@game_board[8]}"
  end

  def pick_first_player
    iter = rand(0..1)
    if iter.zero?
      @temp_name = @p1_name
      @p1_name = @p2_name
      @p2_name = @temp_name
    end
  end

  def get_input(player, marker)
    puts "#{player}, pick a cell."
    @player_choice = gets.chomp
    if @game_board.include?(@player_choice)
      @player_choice = @player_choice.to_i - 1
      if @game_board[@player_choice] != 'X' && @game_board[@player_choice] != 'O' && @player_choice < 9
        @game_board[@player_choice] = marker
      end
    else
      puts 'Please pick an empty cell.'
      get_input(player, marker)
    end
  end

  def check_winner
    winning_lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    winning_lines.each do |line|
      if line.all? { |element| @game_board[element] == 'X' }
        @winner = @p1_name
      elsif line.all? { |element| @game_board[element] == 'O' }
        @winner = @p2_name
      end
    end
  end

  public

  def play_game
    update_board
    pick_first_player

    while !@winner && @turn_count < 10
      if @turn_count.odd? ? get_input(@p1_name, 'X') : get_input(@p2_name, 'O'); end
      update_board
      check_winner
      @turn_count += 1
    end

    if !@winner
      puts 'This is a tie!'
    else
      puts "The winner is #{@winner}!"
    end
  end
end

new_game = TicTacToe.new
new_game.play_game
