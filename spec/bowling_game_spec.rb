require 'rspec'
require_relative '../rubybowling'

describe BowlingGame do
  let(:game) { BowlingGame.new }

  describe '#add_one_player' do
    it 'adds a player to the game' do
      game.add_player("Alice")
      expect(game.players.length).to eq(1)
    end
  end

  describe '#add_two_players' do
    it 'adds a player to the game' do
      game.add_player("Alice")
      game.add_player("Jean")
      expect(game.players.length).to eq(2)
    end
  end
end