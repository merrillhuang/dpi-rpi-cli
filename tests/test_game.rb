require 'minitest/autorun'
require_relative '../game'

class RPSGameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_init
    assert_equal ["Rock", "Paper", "Scissors"], @game.choices, "Game not initialized properly"
    assert_equal [], @game.players, "Game not initialized properly"
  end

  def test_change_player
    assert_output(/The current player is Joe./) do
      @game.change_player("Joe")
    end
    assert_equal 1, @game.players.length, "Player not added"
    assert_equal "Joe", @game.players[0].name, "Player not added"
    choices = {"Wins" => 0, "Losses" => 0, "Ties" => 0}
    assert_equal choices, @game.players[0].record, "Player not added"

    assert_output(/The current player is Joe./) do
      @game.change_player("Joe")
    end
  end

  def test_get_winner
    assert_output(/The current player is Joe./) do
      @game.change_player("Joe")
    end
    assert_output(/It's a tie/) do
      @game.get_winner("Scissors", "Scissors")
    end
    choices = {"Wins" => 0, "Losses" => 0, "Ties" => 1}
    assert_equal choices, @game.players[0].record, "Tie not added to record"
  end
end
