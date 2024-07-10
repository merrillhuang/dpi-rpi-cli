class Player
  attr_accessor :name, :record

  def initialize(name)
    @name = name
    @record = {"Wins" => 0, "Losses" => 0, "Ties" => 0}
  end
end
