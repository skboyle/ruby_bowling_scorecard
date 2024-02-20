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

describe Frame do
  let(:frame) { Frame.new }

  describe '#initialize' do
    it 'sets default values' do
      expect(frame.top).to eq(0)
      expect(frame.bottom).to eq(0)
      expect(frame.bonus).to eq(0)
      expect(frame.special).to eq("none")
      expect(frame.previous_frame).to be_nil
    end
  end

  describe '#score' do
    it 'returns the sum of top, bottom, and bonus' do
      frame.top = 2
      frame.bottom = 3
      frame.bonus = 1
      expect(frame.score).to eq(6)
    end
  end
end

describe Player do
  let(:player) { Player.new("Alice") }

  describe '#initialize' do
    it 'sets default values' do
      expect(player.name).to eq("Alice")
      expect(player.frames).to eq([])
      expect(player.total_score).to eq(0)
    end
  end

  describe '#add_frame' do
    it 'adds a frame to the player' do
      frame = double('frame')
      player.add_frame(frame)
      expect(player.frames).to eq([frame])
    end
  end
end