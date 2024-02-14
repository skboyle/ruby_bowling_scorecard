require 'rspec'
require_relative '../rubybowling'

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
