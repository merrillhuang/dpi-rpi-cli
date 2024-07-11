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
end
