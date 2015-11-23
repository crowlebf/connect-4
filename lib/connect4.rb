require_relative "board"
require_relative "player"
require "pry"

class Connect4
  attr_accessor :current_player , :opponent, :p1 , :p2 , :board

  def initialize()
    @board = Board.new
    @p1 = nil
    @p2 = nil
  end

  def play
    puts "Welcome to Connect 4!"
    get_player_names

    player_counter = 0

    while !@board.grid_full?
      @board.print_grid
      puts
      index = prompt_player_choice.to_i
      if !board.column_full?(index)
        row = board.add_chip(current_player, index).to_i

        if board.winner?(row , index, opponent)

          @board.print_grid
          puts
          puts "#{current_player.name} has won!"
          break
        end
      else
        puts "Column is full."
        next
      end
      player_counter += 1
      switch_players(player_counter)
    end
  end

  def get_player_names
    print "Player 1, enter name: "
    p1_name = gets.chomp
    puts
    print "Player 2, enter name: "
    p2_name = gets.chomp
    puts

    while p1_name.downcase == p2_name.downcase
      print "Player 2, please enter unique name: "
      p2_name = gets.chomp
      puts
    end

    @p1 = Player.new(p1_name, "X")
    @p2 = Player.new(p2_name, "O")
    @current_player = p1
    @opponent = p2
  end

  def switch_players(player_counter)

    if player_counter%2 == 0
      @current_player = p1
      @opponent = p2
    else
      @current_player = p2
      @opponent = p1
    end
  end

  def prompt_player_choice

    print "#{current_player.name} please select a column to drop chip in: "
    choice = gets.chomp
    while not_valid_chip?(choice)
      print "Invalid entry, choose again: "
      choice = gets.chomp
    end
    puts
    return choice
  end

  def print_legend

  end

  def not_valid_chip?(choice)
    valid = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    !valid.include?(choice) || choice.to_i > 9 || choice.to_i < 0
  end
end

game = Connect4.new
game.play
