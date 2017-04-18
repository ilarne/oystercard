require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:balance) }

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'tops up balance by specified amount' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end

    it 'raises an error if top-up would push balance above £90' do
      expect{ subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end

  end

  describe '#spend' do
    it "reduces balance by given amount" do
      subject.top_up(50)
      expect(subject.spend(40)).to eq 10
    end
  end

  describe '#in_journey?' do
    it 'expect journey to be false to begin with' do
      expect(subject.in_journey?).to be(false)
    end
  end

  describe '#touch_in' do
    it 'makes in journey status true' do
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it 'makes in journey status false' do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end


end
