require 'oystercard'

describe Oystercard do
  let (:station){double(:station)}

  it { is_expected.to respond_to(:balance) }

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it { is_expected.to respond_to(:entry_station) }

  describe '#top_up' do
    it 'tops up balance by specified amount' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end

    it 'raises an error if top-up would push balance above £90' do
      expect{ subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end

  end

  describe '#deduct' do
    it "reduces balance by given amount" do
      subject.top_up(50)
      expect(subject.send(:deduct,40)).to eq 10
    end
  end

  describe '#in_journey?' do
    it 'expect journey to be false to begin with' do
      expect(subject.in_journey?).to be(false)
    end
  end

  describe '#touch_in' do
    it 'makes in journey status true' do
      subject.top_up(3)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it 'remembers entry station' do
      subject.top_up(3)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it "raises and error if balance is less than minimum charge" do
      expect {subject.touch_in(station)}.to raise_error "insufficient funds !"
    end
  end

  describe '#((touch_out(station)' do
    it 'makes in journey status false' do
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end

    it 'deducts fare upon touching out' do
      expect {subject.touch_out(station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'sets entry station to nil' do
      subject.top_up(3)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq nil
    end

    it 'creates an exit station on touch out' do
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end
  end
end
