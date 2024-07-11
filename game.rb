require_relative "player"

class Game
  attr_accessor :current_player, :choices, :players

  def initialize()
    @choices = ["Rock", "Paper", "Scissors"]
    @players = []
  end

  def start
    puts "Rock, Paper Scissors!"

    puts "Welcome! What's your name?"
    name = gets.chomp
    puts "Hello #{name}, let's play!"

    change_player(name)

    play
    
    loop do
      option_choice = options

      case option_choice
      when 1
        play
      when 2
        puts "New player! What's your name?"
        name = gets.chomp
        change_player(name)
        play
      when 3
        view_record
      when 4
        break
      end
    end
  end

  def change_player(name)
    player_index = @players.find { |player|
      player.name == name
    }
    if player_index == nil
      @current_player = Player.new(name)
      @players.push(@current_player)
    end
    puts "The current player is #{@current_player.name}."
  end

  def play()
    loop do
      puts "#{@current_player.name}, what are you throwing?\nRock, Paper, or Scissors?"
      
      player_choice = gets.chomp.capitalize
      
      unless @choices.include?(player_choice)
        puts "Oops! Please enter Rock, Paper, or Scissors."
      else
        puts "You threw #{player_choice}!"
        computer_choice = @choices.sample
        puts "The computer threw #{computer_choice}!"
        get_winner(player_choice, computer_choice)
        break
      end
    end
  end

  def get_winner(player_choice, computer_choice)
    case player_choice
    when "Rock"
      if computer_choice == "Rock"
        puts "It's a tie."
        @current_player.record["Ties"] += 1
      elsif computer_choice == "Paper"
        puts "You lost..."
        @current_player.record["Losses"] += 1
      else
        puts "You won!"
        @current_player.record["Wins"] += 1
      end
    when "Paper"
      if computer_choice == "Paper"
        puts "It's a tie."
        @current_player.record["Ties"] += 1
      elsif computer_choice == "Scissors"
        puts "You lost..."
        @current_player.record["Losses"] += 1
      else
        puts "You won!"
        @current_player.record["Wins"] += 1
      end
    when "Scissors"
      if computer_choice == "Scissors"
        puts "It's a tie."
        @current_player.record["Ties"] += 1
      elsif computer_choice == "Rock"
        puts "You lost..."
        @current_player.record["Losses"] += 1
      else
        puts "You won!"
        @current_player.record["Wins"] += 1
      end
    end
  end

  def options
    puts "What next?"

    loop do
      puts "Options: "
      puts "Enter 1 to play another game."
      puts "Enter 2 to let someone else play."
      puts "Enter 3 to view player win-loss records."
      puts "Enter 4 to exit program."
      option_choice = gets.chomp.to_i
      if ! [1, 2, 3, 4].include?(option_choice)
        puts "Oops, please enter 1, 2, 3, or 4."
      else
        return option_choice
        break
      end
    end
  end

  def view_record
    loop do
      puts "Enter 1 to view your own win-loss record."
      puts "Enter 2 to search for another player's win-loss record."
      puts "Enter 3 to view all player win-loss records."
      puts "Enter 4 to stop viewing records."

      choice = gets.chomp.to_i

      case choice
      when 1
        puts "#{@current_player.name}, your record is #{current_player.record}."
      when 2
        puts "Please enter the name of the player you are looking for."
        name = gets.chomp
        player = @players.find { |player|
          player.name == name
        }
        if player == nil
          puts "Sorry! No player with name #{name} in our records."
        else
          puts "#{player.name}'s record is #{player.record}."
        end
      when 3
        i = 1
        @players.each { |player, record|
          puts "#{i}. #{player.name}'s record is #{player.record}."
          i += 1
        }
      when 4
        break
      else
        puts "Oops, invalid choice. Please enter 1, 2, 3, or 4."
      end
    end
  end
end
