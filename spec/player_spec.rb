require 'rspec'
require_relative '../rubybowling'

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