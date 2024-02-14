require 'rspec'
require_relative '../rubybowling'

describe BowlingGame do
  let(:game) { BowlingGame.new }

  describe '#add_player' do
    it 'adds a player to the game' do
      game.add_player("Alice")
      expect(game.players.length).to eq(1)
    end
  end

  # Write more tests for other methods as needed
end